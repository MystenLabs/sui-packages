module 0xf1eaea0370db9025b57b8cfdf11aebcb0edd4eb7ab0e9fbd9fd83eae611c7fb3::rugpull {
    struct RUGPULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGPULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGPULL>(arg0, 9, b"RugPull", b"Rug Pull Coin", b"Definitely not a rug pull attempt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fcafebazaar.ir%2Fapp%2Fcom.stickers.brainlets%3Fl%3Den&psig=AOvVaw2q2czasZYQza5d2JMOr-Kg&ust=1741816746202000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCNC575aDg4wDFQAAAAAdAAAAABAJ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RUGPULL>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGPULL>>(v2, @0x7f08dfdd6580de20e09fbdb68cae339a41ffff10b1e48f80f41ff8443f71db8d);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGPULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

