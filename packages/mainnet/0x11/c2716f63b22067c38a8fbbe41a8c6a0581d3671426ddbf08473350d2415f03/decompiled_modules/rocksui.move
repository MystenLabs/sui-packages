module 0x11c2716f63b22067c38a8fbbe41a8c6a0581d3671426ddbf08473350d2415f03::rocksui {
    struct ROCKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKSUI>(arg0, 6, b"RockSui", b"Rock Sui", x"2024524f434b202f726b2f203d205261692053746f6e6573203d204469737472696275746564204c6564676572203d204f726967696e616c2043727970746f203d2043727970746f203d2043757272656e6379206f6620477275677a203d20436f6d6d756e697479204f776e6564204d656d65636f696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_9c8891383d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

