module 0xa5bcba4509ff018192e7fba4fddfb3cf926be0a46f39bbea62d92ace6c565022::suscat {
    struct SUSCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSCAT>(arg0, 9, b"SUSCAT", b"DERPLUNA", b"Delicious cat that will judge you while filling your pockets with gold ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/503d1c07-8f44-4bf1-92d8-2eb60265da69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

