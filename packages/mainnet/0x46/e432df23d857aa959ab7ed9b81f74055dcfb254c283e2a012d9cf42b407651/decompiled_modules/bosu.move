module 0x46e432df23d857aa959ab7ed9b81f74055dcfb254c283e2a012d9cf42b407651::bosu {
    struct BOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSU>(arg0, 6, b"BOSU", b"Book Of Sui ", x"426f6f6b206f6620537569206973207468652066697273742070726573616c6520626f726e2066726f6d2058206f6e207468652053756920636861696e20e28094206e6f2072756c65732c206e6f20726f61646d61702c206a75737420726177206d656d6520656e6572677920616e64206f6e2d636861696e206d61646e6573732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748380525763.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

