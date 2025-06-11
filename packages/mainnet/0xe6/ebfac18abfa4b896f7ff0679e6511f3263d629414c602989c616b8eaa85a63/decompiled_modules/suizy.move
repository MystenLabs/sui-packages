module 0xe6ebfac18abfa4b896f7ff0679e6511f3263d629414c602989c616b8eaa85a63::suizy {
    struct SUIZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZY>(arg0, 6, b"SUIZY", b"Young Suizy", x"245355495a592069736e2774206a75737420616e6f74686572206d656d65636f696e20206974277320796f7572207469636b657420746f2074686520756c74696d6174652073756920626c6f636b636861696e20657870657269656e636521204a6f696e20612072617069646c792067726f77696e6720636f6d6d756e697479206f6620686f6c646572732077686f2061726520726964696e6720746865207761766520746f2066696e616e6369616c2066726565646f6d207768696c6520656e6a6f79696e67206578636c7573697665207065726b73210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250611_122406_335_0f32ac5a8d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

