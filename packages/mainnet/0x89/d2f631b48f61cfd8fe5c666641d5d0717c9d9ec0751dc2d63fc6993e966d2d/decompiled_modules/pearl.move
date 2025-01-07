module 0x89d2f631b48f61cfd8fe5c666641d5d0717c9d9ec0751dc2d63fc6993e966d2d::pearl {
    struct PEARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEARL>(arg0, 6, b"PEARL", b"SUI PEARL", x"57656c636f6d6520746f2053756920506561726c20636f6d6d756e69747920207468652068696464656e2067656d206f6e207375692e200a42696720706172746e65727368697020636f6d696e67207570204e4f5721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_19_14_32_15_e36319db8a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

