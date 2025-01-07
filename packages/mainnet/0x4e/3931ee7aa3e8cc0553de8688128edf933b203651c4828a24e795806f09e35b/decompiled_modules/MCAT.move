module 0x4e3931ee7aa3e8cc0553de8688128edf933b203651c4828a24e795806f09e35b::MCAT {
    struct MCAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MCAT>, arg1: 0x2::coin::Coin<MCAT>) {
        0x2::coin::burn<MCAT>(arg0, arg1);
    }

    fun init(arg0: MCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCAT>(arg0, 2, b"MCAT", b"SUI CAT MEMES", b"if you laugh at this picture, you can buy some coins for support, thanks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/f9QrMXR/mycat.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MCAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

