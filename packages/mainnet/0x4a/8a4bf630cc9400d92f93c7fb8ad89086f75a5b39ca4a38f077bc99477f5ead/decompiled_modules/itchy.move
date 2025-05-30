module 0x4a8a4bf630cc9400d92f93c7fb8ad89086f75a5b39ca4a38f077bc99477f5ead::itchy {
    struct ITCHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITCHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITCHY>(arg0, 6, b"ITCHY", b"Itchy Scratchy", b"ITCHY is bringing his old-school mischievous charm to the blockchain. ready to dash through the digital age with the cunning and clever antics we have all come to love. This isnt just another token. its a revival of timeless strategy and wit. all wrapped up in the innovative potential of SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia3ntiduul3qz7fbo6dvmmljxz5szo24ffdo6dznd3nrzjsll4asi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITCHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ITCHY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

