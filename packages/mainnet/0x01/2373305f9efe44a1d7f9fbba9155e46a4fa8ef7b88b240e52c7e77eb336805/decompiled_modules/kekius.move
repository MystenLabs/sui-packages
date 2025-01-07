module 0x12373305f9efe44a1d7f9fbba9155e46a4fa8ef7b88b240e52c7e77eb336805::kekius {
    struct KEKIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKIUS>(arg0, 9, b"KEKIUS", b"Kekius Maximus", b"Kekius Maximus on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/tySDiUdQRpxJ7Sji8073asmJlSI4HrroJbCwKtOKtXk")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KEKIUS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKIUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEKIUS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

