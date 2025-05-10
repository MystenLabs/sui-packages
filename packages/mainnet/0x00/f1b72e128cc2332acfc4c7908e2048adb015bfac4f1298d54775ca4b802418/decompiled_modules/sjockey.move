module 0xf1b72e128cc2332acfc4c7908e2048adb015bfac4f1298d54775ca4b802418::sjockey {
    struct SJOCKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJOCKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJOCKEY>(arg0, 6, b"SJockey", b"Suiken Jockey", b"Chicken Jockey in Sui? Call me Suiken Jockey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibtenqci5xfibgqzxvxppwauxkukmqxfsj5o2mky63qwwbnvqtqum")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJOCKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SJOCKEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

