module 0x480e89ed4e53909c6d2cad5d3fff6389780f7df2c22e217304a19ce8977fa8a2::xpro {
    struct XPRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XPRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XPRO>(arg0, 6, b"XPRO", b"X Pro", b"XPRO Token is a blockchain-based token connected to the SUI network and focused on developing the social media ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010076_7d99993ef4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XPRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XPRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

