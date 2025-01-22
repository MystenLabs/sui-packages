module 0xa61ca4096e73458974a0600ad89f48eff5a78c0564017416d4ffc5ab91a4a92c::mevbet {
    struct MEVBET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEVBET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEVBET>(arg0, 6, b"MEVBET", b"MevBet AI", b"MevBet AI is a decentralized platform combining artificial intelligence and blockchain transparency to redefine sports betting arbitrage. By leveraging unmatched computational power and market inefficiencies, MEVBET AI empowers users with guaranteed risk-free betting opportunities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_164230_606_77a5a58846.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEVBET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEVBET>>(v1);
    }

    // decompiled from Move bytecode v6
}

