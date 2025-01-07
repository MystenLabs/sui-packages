module 0xc71d5dfab47b19f7eed152a2497498e63da3554958b323aff536f0890e4a15ec::fat {
    struct FAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAT>(arg0, 6, b"FAT", b"Frog Cat Sui", b"Frog Cat on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/frogcat_1256cb6358.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

