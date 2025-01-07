module 0x236d3ba830e19c12539fbec0fe6504b62e9123e71fc95e423f2d30be6104bf0d::suitcat {
    struct SUITCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITCAT>(arg0, 6, b"Suitcat", b"SuitCat", x"53756974436174206f6620746865205375692065636f73797374656d206973206865726520746f206275696c642074686520756c74696d61746520636f6d6d756e69747920666f722074727565205375692066616e732120546f6765746865722c2077656c6c2067726f77207468652053756920636f6d6d756e6974792c20637265617465206578636974696e672070726f6a656374732c20616e642077656c636f6d65206e657720667269656e647320746f20537569744361742e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitcat_3ef978aa87.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

