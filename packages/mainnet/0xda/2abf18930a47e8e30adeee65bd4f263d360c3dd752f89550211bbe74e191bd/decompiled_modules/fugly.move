module 0xda2abf18930a47e8e30adeee65bd4f263d360c3dd752f89550211bbe74e191bd::fugly {
    struct FUGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUGLY>(arg0, 6, b"FUGLY", b"FUGLY FAM", b"The Gangs All Here. FUGLY FAM on SUI. All token holders will be screenshotted and whitelisted for our official NFT collection release.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500_x_500_4e356e70d7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUGLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

