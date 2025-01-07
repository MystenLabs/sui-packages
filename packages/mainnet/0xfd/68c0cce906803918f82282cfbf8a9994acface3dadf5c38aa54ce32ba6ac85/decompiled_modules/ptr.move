module 0xfd68c0cce906803918f82282cfbf8a9994acface3dadf5c38aa54ce32ba6ac85::ptr {
    struct PTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTR>(arg0, 9, b"PTR", b"Patar", b"Tobanga patar tobanga du", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26d8406b-bc79-48c9-92ce-8f0b4b3c7955.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

