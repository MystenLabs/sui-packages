module 0xfb7178e986fc8d10b74a51935caf2d407e64ad5304917934129f09bbb1bb061e::chef {
    struct CHEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEF>(arg0, 6, b"CHEF", b"Cat eating fish", b"CHEF is a meme token on the SUI blockchain, featuring a playful cat enjoying its favorite fish treat. Join the CHEF community for a purr-fect crypto experience!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1240_b6f36be2e0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

