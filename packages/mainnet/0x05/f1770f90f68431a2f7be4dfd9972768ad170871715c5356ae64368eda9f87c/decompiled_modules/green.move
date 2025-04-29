module 0x5f1770f90f68431a2f7be4dfd9972768ad170871715c5356ae64368eda9f87c::green {
    struct GREEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEN>(arg0, 6, b"GREEN", b"SUI GREEN", b"it's me GREEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/green_0bb79eb348.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

