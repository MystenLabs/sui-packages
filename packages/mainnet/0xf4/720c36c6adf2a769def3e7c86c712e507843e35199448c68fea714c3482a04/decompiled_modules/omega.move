module 0xf4720c36c6adf2a769def3e7c86c712e507843e35199448c68fea714c3482a04::omega {
    struct OMEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OMEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMEGA>(arg0, 6, b"OMEGA", b"OMEGA", b"fuel for souls seeking max power on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.omegatermsui.xyz/OMEGA_files/icon.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OMEGA>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OMEGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMEGA>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

