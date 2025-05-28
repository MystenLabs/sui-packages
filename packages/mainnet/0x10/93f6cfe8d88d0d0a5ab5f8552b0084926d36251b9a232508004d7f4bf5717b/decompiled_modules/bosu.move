module 0x1093f6cfe8d88d0d0a5ab5f8552b0084926d36251b9a232508004d7f4bf5717b::bosu {
    struct BOSU has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BOSU>, arg1: 0x2::coin::Coin<BOSU>) {
        0x2::coin::burn<BOSU>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOSU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BOSU>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSU>(arg0, 6, b"BOSU", b"Book Of Sui", b"The legendary Book Of Sui - Meme token on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/gigagfun/token-assets/refs/heads/main/Bookofsui.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BOSU>>(0x2::coin::mint<BOSU>(&mut v2, 69420000420000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

