module 0xfca99d03e8e6346976567c2539b5407a12866300a23a1f35bbef665ce7eda46b::n20 {
    struct N20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: N20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<N20>(arg0, 6, b"N20", b"Nitrous Oxide", b"Nitrous Oxide (N20) is an innovative cryptocurrency designed to fuel the future of decentralized finance. With a focus on speed, security, and scalability, N20 aims to empower users by facilitating seamless transactions and smart contracts. Join the", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731402995805.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<N20>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<N20>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

