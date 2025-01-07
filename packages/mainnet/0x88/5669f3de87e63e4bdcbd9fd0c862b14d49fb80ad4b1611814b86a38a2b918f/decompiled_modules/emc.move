module 0x885669f3de87e63e4bdcbd9fd0c862b14d49fb80ad4b1611814b86a38a2b918f::emc {
    struct EMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EMC>(arg0, 8, b"EMC", b"Elon Musk Coin", b"Elon Musk Coin On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JGcrcrv.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EMC>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EMC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

