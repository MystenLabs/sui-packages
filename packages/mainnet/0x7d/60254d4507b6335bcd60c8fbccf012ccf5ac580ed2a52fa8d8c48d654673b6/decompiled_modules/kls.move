module 0x7d60254d4507b6335bcd60c8fbccf012ccf5ac580ed2a52fa8d8c48d654673b6::kls {
    struct KLS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KLS>, arg1: 0x2::coin::Coin<KLS>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<KLS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KLS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KLS>>(0x2::coin::mint<KLS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLS>(arg0, 9, b"KLS", b"Koala Sui", b"Koala Sui is the self burning meme coin based on the Sui. However, unlike others, KLS uses PanS as its trading pair, making it fully part of the PanS ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibdfywcjbv2fouushttw5osstogrdraulyqlnwzxlkk4ftky5su24?filename=kls.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

