module 0xcc455915032b59c9006c16d5f37d5c797ed1c9c94975051859f16dca35b7e21d::officialsuicat {
    struct OFFICIALSUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: OFFICIALSUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OFFICIALSUICAT>(arg0, 6, b"OFFICIALSUICAT", b"SUICAT", b"Official SUICAT MEME, created by the official team, official community will be created in the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e_a_ae_a_e_ae_i_c_955bd0e088.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OFFICIALSUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OFFICIALSUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

