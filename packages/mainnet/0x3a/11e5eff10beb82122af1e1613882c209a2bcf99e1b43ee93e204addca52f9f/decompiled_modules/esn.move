module 0x3a11e5eff10beb82122af1e1613882c209a2bcf99e1b43ee93e204addca52f9f::esn {
    struct ESN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESN>(arg0, 6, b"ESN", b"Satoshi Nakamoto", b"Everyone's Satoshi Nakamoto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_18_03_01_a8b9b4adf3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESN>>(v1);
    }

    // decompiled from Move bytecode v6
}

