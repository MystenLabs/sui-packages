module 0x1972724f1d754d890ac3064553734b744a221beddbb49b8743d219de78de1d8f::qqq6900 {
    struct QQQ6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQQ6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQQ6900>(arg0, 6, b"QQQ6900", b"QQQ6900 Sui", x"5175616e7420657466206d656d65636f696e206e61736461712c207175616e7420696e6465782063727970746f2026207175616e74207765616c74687920646567656e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_01_33_28_8e18c056a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQQ6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QQQ6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

