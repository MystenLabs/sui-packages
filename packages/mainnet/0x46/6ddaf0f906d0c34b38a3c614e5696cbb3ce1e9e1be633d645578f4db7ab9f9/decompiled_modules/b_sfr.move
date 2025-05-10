module 0x466ddaf0f906d0c34b38a3c614e5696cbb3ce1e9e1be633d645578f4db7ab9f9::b_sfr {
    struct B_SFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SFR>(arg0, 9, b"bSFR", b"bToken SFR", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SFR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SFR>>(v1);
    }

    // decompiled from Move bytecode v6
}

