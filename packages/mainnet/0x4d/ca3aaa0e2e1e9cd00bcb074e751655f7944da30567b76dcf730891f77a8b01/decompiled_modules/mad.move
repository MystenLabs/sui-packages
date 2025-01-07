module 0x4dca3aaa0e2e1e9cd00bcb074e751655f7944da30567b76dcf730891f77a8b01::mad {
    struct MAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAD>(arg0, 6, b"MAD", b"MadLeen", b"Madleen is a revolutionary token designed to empower the gaming community, created by pro gamers for pro gamers. This digital token bridges the world of gaming and blockchain, offering players a unique way to earn, trade and invest.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735467476212.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

