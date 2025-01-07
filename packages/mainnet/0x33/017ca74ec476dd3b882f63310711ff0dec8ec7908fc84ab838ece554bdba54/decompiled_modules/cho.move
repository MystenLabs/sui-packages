module 0x33017ca74ec476dd3b882f63310711ff0dec8ec7908fc84ab838ece554bdba54::cho {
    struct CHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHO>(arg0, 6, b"CHO", b"Cho Cat on Sui", x"496e204861692050686f6e672c20566965746e616d2c207468657265206973206120636174206e616d65642043686f207768696368206d65616e732027446f672720696e20766965746e616d6573652e0a4e6f2074672c206e6f20747769747465722c206a757374202443484f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cho_2436fd24f6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

