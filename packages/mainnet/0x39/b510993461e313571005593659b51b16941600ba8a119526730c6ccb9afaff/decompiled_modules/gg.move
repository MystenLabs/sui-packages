module 0x39b510993461e313571005593659b51b16941600ba8a119526730c6ccb9afaff::gg {
    struct GG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GG>(arg0, 6, b"GG", b"Gary Gensler by SuiAI", b"Gary Gensler, the worst SEC chair ever, will resign in a few days!..Every crypto bros knows this name from nightmares...With his resignation, there will be no more stupid charges...do all that you want with this .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Gh0xurabw_AA_5_ZMN_75309e19ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

