module 0x7ea5b573ef71c08722b8b412bc92a1fe7047f0167874cdabe3e1594da66dceb8::suineko {
    struct SUINEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEKO>(arg0, 6, b"SUINEKO", b"NEKO", b"SUINEKOneko", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicsbtqejs66jxtzhkjlgb4disj7nuojkuuimtiwwthbsnwdofv7bu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINEKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

