module 0x4d663e13ec430ed315a00fbc20deb05e5cded4865b482864211362bdbbe42b72::hehe {
    struct HEHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHE>(arg0, 6, b"HEHE", b"HEHE", b"HEHE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/ade8a320-dd63-11ef-a403-694c756e712a")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEHE>>(v1);
        0x2::coin::mint_and_transfer<HEHE>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

