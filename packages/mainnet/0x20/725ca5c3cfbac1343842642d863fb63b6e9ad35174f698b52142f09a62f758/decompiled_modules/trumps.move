module 0x20725ca5c3cfbac1343842642d863fb63b6e9ad35174f698b52142f09a62f758::trumps {
    struct TRUMPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPS>(arg0, 6, b"TRUMPS", b"Trumpstar", b"TRUMPS was developed to make meme culture great again. No utility, Only Meme SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730964635114.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

