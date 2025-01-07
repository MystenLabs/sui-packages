module 0x85c0b26a27e71f2b8f57c6e05924c4ba5473fc17459833fb97c3244dd5b8cf2d::sus {
    struct SUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUS>(arg0, 6, b"SUS", b"Sui Sushi", b"Sui Network's newest NFT marketplace. Earn on referrals. Stake for rewards. Buy, Sell, & Trade. Generate & deploy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suisi_9208297a77.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

