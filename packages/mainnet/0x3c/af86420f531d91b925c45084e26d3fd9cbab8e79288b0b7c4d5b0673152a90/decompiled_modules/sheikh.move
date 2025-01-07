module 0x3caf86420f531d91b925c45084e26d3fd9cbab8e79288b0b7c4d5b0673152a90::sheikh {
    struct SHEIKH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEIKH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEIKH>(arg0, 6, b"SHEIKH", b"SUNSHEIKH", x"204f75722063616d656c732061726520726561647920746f206578706c6f7265206e657720686f72697a6f6e7320776974682074686520535549206361726176616e2c2077686572652074726164696e6720766f6c756d6520666c6f777320617320656e646c6573736c7920617320746865206465736572742073616e64732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sge_e3b0e35e1c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEIKH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEIKH>>(v1);
    }

    // decompiled from Move bytecode v6
}

