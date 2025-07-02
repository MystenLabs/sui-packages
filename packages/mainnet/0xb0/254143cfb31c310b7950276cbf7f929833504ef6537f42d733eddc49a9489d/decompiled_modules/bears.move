module 0xb0254143cfb31c310b7950276cbf7f929833504ef6537f42d733eddc49a9489d::bears {
    struct BEARS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BEARS>, arg1: 0x2::coin::Coin<BEARS>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<BEARS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BEARS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BEARS>>(0x2::coin::mint<BEARS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BEARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEARS>(arg0, 9, b"BearS", b"Bear Sui", b"Bear Sui is the third self burning meme coin based on the Sui. However, unlike others, BearS uses PanS as its trading pair, making it fully part of the PanS ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiddsyywpieo2cev5ayrbaz635rt5l32f4pslrimh23qu6vwv4sh3m?filename=bears.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BEARS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

