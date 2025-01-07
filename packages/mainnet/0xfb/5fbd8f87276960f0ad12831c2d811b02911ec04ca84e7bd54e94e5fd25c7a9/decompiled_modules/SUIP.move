module 0xfb5fbd8f87276960f0ad12831c2d811b02911ec04ca84e7bd54e94e5fd25c7a9::SUIP {
    struct SUIP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIP>, arg1: 0x2::coin::Coin<SUIP>) {
        0x2::coin::burn<SUIP>(arg0, arg1);
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIP>(arg0, 9, b"testSUIP2", b"testSuiPad2", b"testSuiPad2 The Premier Launchpad for Tier-1 Projects", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIP>>(v1);
        0x2::coin::mint_and_transfer<SUIP>(&mut v2, 100000000000000000, @0xe4445b23ba8981f654f7231eb4f9d2ee053eab9ebd42db962c9c50382b3e4e16, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIP>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

