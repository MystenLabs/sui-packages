module 0x4967311c5ff5f23252180a5d520a603c7e778287dec18492ed17ceec157e3df4::bng {
    struct BNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNG>(arg0, 9, b"BNG", b"BNIGER", b"BNIGER is a revolutionary blockchain asset designed to enhance decentralized finance (DeFi) participation. It offers users staking rewards and governance opportunities, fostering community engagement while providing secure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2820897b-3cba-45e4-b49e-dfd6cbea6a88.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

