module 0x8dffd93364c9d33dde50bf05b6e5045bfd8fd00bb69108029f769a5ff42f19cf::capy {
    struct CAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPY>(arg0, 6, b"CAPY", b"Capybara", b"The Friendliest Telegram-Native Meme Coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cx_V1z_S7_400x400_13955812f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

