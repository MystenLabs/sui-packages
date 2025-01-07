module 0xa5bbd5e6bedf05e52b5042518f3ca88fe1722f7d8f8e89d8bc87990f590504fe::bulls {
    struct BULLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLS>(arg0, 6, b"BullS", b"sui bull", b"As the first bull on the Sui network, SUIBULL represents the bullish momentum, innovation, and unstoppable drive toward decentralization", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profpic_bull_6f4fad0bd4_3ebec260f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BULLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

