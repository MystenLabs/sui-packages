module 0x9dabf38e286b637fed2d378f09a9b690d20e6ea21e833362dc9485b1e196e77f::bored_boyz_club {
    struct BORED_BOYZ_CLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORED_BOYZ_CLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORED_BOYZ_CLUB>(arg0, 6, b"BORED BOYZ CLUB", b"BORED", x"426f72656420426f797a20436c7562204d656d65636f696e204f6e207375692077697468207265616c205574696c6974792e0a52454c41554e4348", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibuxmb64uknq7y5cyeenmnugr3iunu7xo75ssbkydah55thno7u5y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORED_BOYZ_CLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BORED_BOYZ_CLUB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

