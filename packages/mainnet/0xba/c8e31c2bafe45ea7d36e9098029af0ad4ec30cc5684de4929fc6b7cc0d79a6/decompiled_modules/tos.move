module 0xbac8e31c2bafe45ea7d36e9098029af0ad4ec30cc5684de4929fc6b7cc0d79a6::tos {
    struct TOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOS>(arg0, 6, b"TOS", b"TURBO ON SUI", b"Turbo on Sui (TOS) is the high-octane, no-holds-barred memecoin for speed enthusiasts and blockchain rebels. Inspired by Turbo coin on ETH, this is where velocity meets virality. Whether you're in for the gains or just the vibes, Turbo is built for those who live fast and meme faster!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/TURBO_18dce8da04.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

