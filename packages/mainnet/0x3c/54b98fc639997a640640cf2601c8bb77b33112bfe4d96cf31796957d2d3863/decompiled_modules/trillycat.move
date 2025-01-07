module 0x3c54b98fc639997a640640cf2601c8bb77b33112bfe4d96cf31796957d2d3863::trillycat {
    struct TRILLYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRILLYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRILLYCAT>(arg0, 6, b"TRILLYCAT", b"Trilly da cat", b"Just my cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5789509799707263752_y_8510120dde.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRILLYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRILLYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

