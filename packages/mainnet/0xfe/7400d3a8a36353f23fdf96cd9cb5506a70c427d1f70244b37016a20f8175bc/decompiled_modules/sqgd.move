module 0xfe7400d3a8a36353f23fdf96cd9cb5506a70c427d1f70244b37016a20f8175bc::sqgd {
    struct SQGD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQGD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SQGD>(arg0, 6, b"SQGD", b"Squade Game", b"Squid Game (SQGM) is a revolutionary cryptocurrency token built on the SUI network, designed to integrate with interactive gaming and rewards platforms. This token powers a unique ecosystem where participants can earn rewards through skill-based competitions and challenges, reminiscent of the strategic and high-stakes environment depicted in its namesake series. SQGM aims to transform how players engage with online games, providing a blockchain-backed platform for secure, transparent, and thrilling gameplay.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/samvel_97_Design_a_visually_stunning_and_artistic_emblem_for_a_db398771_3581_42e0_a44a_0aba37bddb05_0fb85ad21e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQGD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQGD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

