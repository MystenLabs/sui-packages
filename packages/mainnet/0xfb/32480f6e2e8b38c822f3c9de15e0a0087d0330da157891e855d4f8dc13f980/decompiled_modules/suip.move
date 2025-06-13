module 0xfb32480f6e2e8b38c822f3c9de15e0a0087d0330da157891e855d4f8dc13f980::suip {
    struct SUIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIP>(arg0, 6, b"SUIP", b"Suipad", b"Access SuiPad top tier crypto IDO projects before they hit the market. Stake SUIP tokens to get priority access to promising projects", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid47taurrvo7gsa44ip46adek2t7xnczriogmdxldo6yru4wbspo4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

