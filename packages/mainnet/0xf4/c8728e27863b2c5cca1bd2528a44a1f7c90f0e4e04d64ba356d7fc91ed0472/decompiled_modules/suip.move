module 0xf4c8728e27863b2c5cca1bd2528a44a1f7c90f0e4e04d64ba356d7fc91ed0472::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUIP>(arg0, 6, 0x1::string::utf8(b"REWARD"), 0x1::string::utf8(b"Reward Token"), 0x1::string::utf8(b"Protocol reward distribution token"), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIP>>(0x2::coin::mint<SUIP>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUIP>>(0x2::coin_registry::finalize<SUIP>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIP>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to(arg0: &mut 0x2::coin::TreasuryCap<SUIP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIP>>(0x2::coin::mint<SUIP>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v7
}

