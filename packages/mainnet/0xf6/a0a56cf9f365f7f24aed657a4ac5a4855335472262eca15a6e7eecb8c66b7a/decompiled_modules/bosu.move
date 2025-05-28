module 0xf6a0a56cf9f365f7f24aed657a4ac5a4855335472262eca15a6e7eecb8c66b7a::bosu {
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
        let (v0, v1) = 0x2::coin::create_currency<BOSU>(arg0, 6, b"BOSU", b"Book Of Sui", x"426f6f6b206f6620537569206973207468652066697273742070726573616c6520626f726e2066726f6d2058206f6e207468652053756920636861696e20e28094206e6f2072756c65732c206e6f20726f61646d61702c206a75737420726177206d656d6520656e6572677920616e64206f6e2d636861696e206d61646e6573732e2040506f776572656420427920426f6f6b4f66537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/gigagfun/token-assets/refs/heads/main/Bookofsui.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BOSU>>(0x2::coin::mint<BOSU>(&mut v2, 69420000420000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

