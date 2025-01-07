module 0xdc7c15da54a51ab8237f9d6244f3f37df341cab4840ad9025beb90c4eb9120a5::richos {
    struct RICHOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICHOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICHOS>(arg0, 6, b"RICHOS", b"Petrichor on SUI", x"46726f6d206d656d6520746f2048756d616e6974790a5265616c20576f726c6420466f756e646174696f6e0a4c696b6520506574726963686f722c200a686f70652067726f77732066726f6d2062617272656e206c616e6420636f7665726564206279207261696e77617465722c200a6272696e67696e672061206e6577207363656e74206f66206c696665", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732107050781.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICHOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICHOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

