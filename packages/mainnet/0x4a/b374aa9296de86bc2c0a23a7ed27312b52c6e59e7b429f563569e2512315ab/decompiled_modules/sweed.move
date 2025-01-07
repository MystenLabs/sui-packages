module 0x4ab374aa9296de86bc2c0a23a7ed27312b52c6e59e7b429f563569e2512315ab::sweed {
    struct SWEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEED>(arg0, 6, b"SWEED", b"Sweed", x"4d6565742053574545442c207468652068696768657374206d656d626572206f66207468652067726f75702e2048652077617320736f2073746f6e65642074686174206865206d69737365642074686520696e7669746174696f6e20746f206a6f696e2074686520426f79737320436c75622e486973206d697373696f6e20697320746f206d616b65205357454544206120686f757365686f6c64206e616d652c20666f73746572696e67206120636f6d6d756e69747920746861742067657473206869676820746f6765746865722e20497473205357454544277320576f726c643b20796f757265206a757374206c6976696e6720696e2069742e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sans_titre_1_2dfe72552f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWEED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWEED>>(v1);
    }

    // decompiled from Move bytecode v6
}

