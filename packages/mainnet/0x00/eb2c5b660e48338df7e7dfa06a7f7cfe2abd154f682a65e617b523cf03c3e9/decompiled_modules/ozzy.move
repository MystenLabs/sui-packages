module 0xeb2c5b660e48338df7e7dfa06a7f7cfe2abd154f682a65e617b523cf03c3e9::ozzy {
    struct OZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OZZY>(arg0, 6, b"OZZY", b"Sui Ozzy", x"5375694f7a7a792c20616c736f206b6e6f776e20617320244f5a5a5920697320616e206f7474657220636f696e2063726561746564206f7574206f66206c6f766520666f72206f74746572732077697468207468652061696d206f662068656c70696e6720616e642067726f77696e672077697468206f7468657220636f6d6d756e6974696573206f6e2074686520737569206e6574776f726b0a2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007827_8944ba4b3c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

