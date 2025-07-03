module 0xfb9be285bd084ccde25702f63d0de5fca13977d9455fab78f27ae9bf926a4534::lions {
    struct LIONS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<LIONS>, arg1: 0x2::coin::Coin<LIONS>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<LIONS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LIONS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LIONS>>(0x2::coin::mint<LIONS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LIONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIONS>(arg0, 9, b"LionS", b"Lion Sui", b"Lion Sui is the self burning meme coin based on the Sui. However, unlike others, LionS uses PanS as its trading pair, making it fully part of the PanS ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicr54qfadl3ierfp4cmjtdcrs66aiqlawtumpwjnhldyeefpup7fe?filename=lions.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LIONS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

