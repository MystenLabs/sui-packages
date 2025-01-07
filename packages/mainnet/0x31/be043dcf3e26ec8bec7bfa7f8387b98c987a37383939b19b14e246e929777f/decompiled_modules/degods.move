module 0x31be043dcf3e26ec8bec7bfa7f8387b98c987a37383939b19b14e246e929777f::degods {
    struct DEGODS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGODS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGODS>(arg0, 6, b"Degods", b"Degods On Sui", b"Send $Degods on sui to 1B $ marketcap and then ......", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/degods_logo_b8e27c0733.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGODS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGODS>>(v1);
    }

    // decompiled from Move bytecode v6
}

