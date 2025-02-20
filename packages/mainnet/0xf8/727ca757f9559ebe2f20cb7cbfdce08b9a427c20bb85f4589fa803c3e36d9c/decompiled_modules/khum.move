module 0xf8727ca757f9559ebe2f20cb7cbfdce08b9a427c20bb85f4589fa803c3e36d9c::khum {
    struct KHUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHUM>(arg0, 12, b"khum", b"khum", b"khum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"khum")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KHUM>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHUM>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KHUM>>(v2);
    }

    // decompiled from Move bytecode v6
}

