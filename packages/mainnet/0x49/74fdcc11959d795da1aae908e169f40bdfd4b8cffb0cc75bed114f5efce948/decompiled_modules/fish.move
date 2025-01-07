module 0x4974fdcc11959d795da1aae908e169f40bdfd4b8cffb0cc75bed114f5efce948::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 6, b"FISH", b"HopFish", x"486f704669736820697320666f722074686f73652077686f20617265206e6f742061667261696420746f207269736b2065766572797468696e6720746f206a756d7020666f720a612070726f6669742e204f6e65206461792074686520666973682077696c6c206a756d7020736f206869676820746861742069742077696c6c20666c7920737472616967687420746f0a746865206d6f6f6e212020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_8_E4lh_400x400_146dada3d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

