module 0xf8512afee2f8f8517e626ab5020ad0febf119fd1cac1267cfa484d7823073544::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIP>, arg1: 0x2::coin::Coin<SUIP>) {
        0x2::coin::burn<SUIP>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<SUIP>, arg1: &mut 0x2::coin::Coin<SUIP>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SUIP>(arg0, 0x2::coin::split<SUIP>(arg1, arg2, arg3));
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIP>(arg0, 6, b"SUIP", b"SUIP", b"SuiPad Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1638467235810541573/HKnYMwHC_400x400.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIP>(&mut v2, 314000000000000000, @0xffed1e3a3b44c55d8a1300bf9ad7abb11825d45e66ab4bcadb5f7b5f4bce7d3a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

