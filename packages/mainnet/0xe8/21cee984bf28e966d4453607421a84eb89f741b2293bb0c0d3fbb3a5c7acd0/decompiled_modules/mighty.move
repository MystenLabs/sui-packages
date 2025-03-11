module 0xe821cee984bf28e966d4453607421a84eb89f741b2293bb0c0d3fbb3a5c7acd0::mighty {
    struct MIGHTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIGHTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIGHTY>(arg0, 8, b"Mighty", b"Mighty", b"security ensured", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MIGHTY>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIGHTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIGHTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

