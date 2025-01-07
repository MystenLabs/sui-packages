module 0xcd2da4b07ab5aea1ac9f1b0a5ab2fe851dd260cac59284fd3d31d038b1ece6a::wcdognlad {
    struct WCDOGNLAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCDOGNLAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCDOGNLAD>(arg0, 6, b"WcDognlad", b"WcDognlad Sui", b"Yo, meet WcDognlad aka WcDog, this dogs like the meme king of WcDonalds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_1024x1024_18403f064a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCDOGNLAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCDOGNLAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

