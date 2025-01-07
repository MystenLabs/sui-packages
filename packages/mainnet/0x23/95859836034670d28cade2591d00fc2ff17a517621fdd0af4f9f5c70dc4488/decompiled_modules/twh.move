module 0x2395859836034670d28cade2591d00fc2ff17a517621fdd0af4f9f5c70dc4488::twh {
    struct TWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWH>(arg0, 6, b"TWH", b"TrumpWifHat", b"Trump Wif Hat -big laughs, bold moves, meme magic on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PHOTO_2024_11_02_19_12_17_a2b82707b0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

