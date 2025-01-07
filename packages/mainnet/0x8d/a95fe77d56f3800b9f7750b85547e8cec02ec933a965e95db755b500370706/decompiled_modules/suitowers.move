module 0x8da95fe77d56f3800b9f7750b85547e8cec02ec933a965e95db755b500370706::suitowers {
    struct SUITOWERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOWERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOWERS>(arg0, 6, b"SUITOWERS", b"Sui Towers", x"24535549544f574552532077657265206372656174656420746f207065727065747561746520746865206d656d6f7279206f6620746865206c6567656e64617279205477696e20546f776572732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_30321e3bcd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOWERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOWERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

