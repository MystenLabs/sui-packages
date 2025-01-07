module 0xe24834be10f7d55a4656b385028ce3702d9fd2eb88d7f601eb9352ff4c3e7fe5::slongmao {
    struct SLONGMAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLONGMAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLONGMAO>(arg0, 6, b"sLONGMAO", b"LONG MAO", b"LONG MAO is a meme token on the SUI blockchain that combines the power of decentralized finance with the viral nature of meme culture. Built on the SUI network, known for its fast transaction speeds and scalable infrastructure, LONG MAO aims to bring fun, community engagement, and innovation to the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_26_at_11_20_07a_pm_813e661412.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLONGMAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLONGMAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

