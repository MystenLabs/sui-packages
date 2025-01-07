module 0xd30c3ee42879431f8c034f565b789405896cea0060aaba45b1b249d0b12b0830::tdm {
    struct TDM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDM>(arg0, 6, b"TDM", b"ToDaMoon", b"Sui To Da Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hq720_f2f6a99849.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TDM>>(v1);
    }

    // decompiled from Move bytecode v6
}

