module 0xe83831569397cfd990ebbe335f14b440a958729808af1027e0045d2b3c24b5c3::suitun {
    struct SUITUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITUN>(arg0, 6, b"SuiTun", b"CapyBara on Sui (SuiTun)", b"The capybara symbolizes happiness and harmony and looks forward to a carefree life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Tun_86164dc982.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

