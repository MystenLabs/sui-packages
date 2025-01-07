module 0x9f410826e466c79f16d85af3c9b09627ea79319ed70fa5fe345d6755cdcc6e56::gigasui {
    struct GIGASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGASUI>(arg0, 6, b"GIGASUI", b"GigachadSUI", b"Its the Giga Chad meme on Solana, the big one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GIGALOGVIP_0dae27c158.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

