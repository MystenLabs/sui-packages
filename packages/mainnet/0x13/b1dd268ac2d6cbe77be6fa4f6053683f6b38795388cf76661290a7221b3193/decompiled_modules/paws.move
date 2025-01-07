module 0x13b1dd268ac2d6cbe77be6fa4f6053683f6b38795388cf76661290a7221b3193::paws {
    struct PAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWS>(arg0, 6, b"PAWS", b"Referral", b" Welcome to BabyDoge PAWS Clicker! Tap away, gather PAWS, boost your passive income, and create your own earning strategies. Stay tuned for our token airdrop  dates will be announced soon. Join us now and unleash your inner pup! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058011_b846251179.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

