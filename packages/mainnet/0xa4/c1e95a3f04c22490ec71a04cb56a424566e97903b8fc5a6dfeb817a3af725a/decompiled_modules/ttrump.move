module 0xa4c1e95a3f04c22490ec71a04cb56a424566e97903b8fc5a6dfeb817a3af725a::ttrump {
    struct TTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTRUMP>(arg0, 6, b"TTRUMP", b"$T-TRUMP", b"T-trump is the new Technology build and based by Donald j trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logotoken_2_3538192ef7.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

