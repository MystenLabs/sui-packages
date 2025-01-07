module 0x3deaebb3ad8e8e7a752d02696f0a79825596f46d432417067632a75201e90652::mog {
    struct MOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOG>(arg0, 6, b"MOG", b"SUIMOG", b"SuimogCoin (SUI) is the sleep-lovers cryptocurrency, rewarding holders for taking naps instead of tracking the market. Invest in rest and dream big with Suimog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/memes_suitama_c7f5c2e873.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

