module 0x893673873235f2b1ec84d129bba24e3880915af900567b12a43c56d83a56059c::KEKIU {
    struct KEKIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKIU>(arg0, 9, b"KEKIU", b"KEKIU", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKIU>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KEKIU>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<KEKIU>>(0x2::coin::mint<KEKIU>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

