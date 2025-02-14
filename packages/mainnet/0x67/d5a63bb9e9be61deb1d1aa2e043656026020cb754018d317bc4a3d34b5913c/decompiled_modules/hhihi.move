module 0x67d5a63bb9e9be61deb1d1aa2e043656026020cb754018d317bc4a3d34b5913c::hhihi {
    struct HHIHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHIHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHIHI>(arg0, 9, b"hhihi", b"hhihi", b"hhihi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"hhihi")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HHIHI>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HHIHI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HHIHI>>(v2);
    }

    // decompiled from Move bytecode v6
}

