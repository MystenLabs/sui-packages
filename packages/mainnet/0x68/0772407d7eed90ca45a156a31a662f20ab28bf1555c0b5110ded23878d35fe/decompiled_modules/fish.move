module 0x680772407d7eed90ca45a156a31a662f20ab28bf1555c0b5110ded23878d35fe::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 6, b"FISH", b"Fishio", x"46697368696f206a757374207377616d206f6e746f2074686520537569206e6574776f726b21202027486f77206d7563682069732074686520666973683f2720456e6f75676820746f206d616b6520776176657321204469766520696e2c20686176652061206c617567682c20616e642072696465207468652074696465206f66207468652066756e6e69657374206d656d65636f696e2061726f75640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hm_M4_FHT_400x400_e27af9dbcd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

