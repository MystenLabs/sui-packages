module 0x6ad023e14b8ddcda530fdca68d4551ae4c9a57b9d64d9a92190b2c3b76ebbbf::spl {
    struct SPL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPL>(arg0, 6, b"Spl", b"Super League", b"Combining the passion of football with the power of meme culture, creating a community-driven token that celebrates the beautiful game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifz3wuykkraadpydzdgyvjmzlnoyjyy7y5yhvdix2tof33hnbfedy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

