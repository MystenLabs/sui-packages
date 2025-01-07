module 0x1fd2ec4906b6f369357fce92964a9e49d6cba45f3d836ecd6e4acae290f69a0f::hoops {
    struct HOOPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOOPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOOPS>(arg0, 6, b"HOOPS", b"HOOPSUI", x"484f4f50532069732074686520666f756e646572206f6620457175616c697a6572206f6e205355492c20746865206c6172676572207468616e206c69666520706572736f6e616c69747920626563616d65206d656d65210a0a576562736974650a686f6f70736d656d652e636f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/New_Project_3_28dbf471e4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOOPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOOPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

