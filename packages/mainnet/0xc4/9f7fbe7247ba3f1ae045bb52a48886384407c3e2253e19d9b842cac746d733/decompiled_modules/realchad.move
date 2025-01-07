module 0xc49f7fbe7247ba3f1ae045bb52a48886384407c3e2253e19d9b842cac746d733::realchad {
    struct REALCHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALCHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REALCHAD>(arg0, 6, b"REALCHAD", b"NonAI Giga Chad", b"Did you know that Gigachad was digitally created and doesn't exist IRL?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/6tUyJyuc69vHyVgthzu9KhF5gFofufEij9hUkZTjd1QN.png?size=lg&key=f4aae8"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REALCHAD>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REALCHAD>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REALCHAD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

