module 0x61cebbfb34395d5704509b6c505e1f3a41004b4fff45894a1fd8e9b5ce51804a::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FOMO>, arg1: 0x2::coin::Coin<FOMO>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<FOMO>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FOMO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FOMO>>(0x2::coin::mint<FOMO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 9, b"FOMO", b"FOMO Sui", b"As the first meme coin on PANS BOX, we will use all trading fees to buy back and burn FOMO.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiak4bmpyumxulhwmjebyge66rsgh24mbab2ukf5ithplszrztizbq?filename=fomo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FOMO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

