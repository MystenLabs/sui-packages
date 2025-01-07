module 0x7cc48bc22675b323caf3243383bf09d127241acb4f67f064e62f9395e3b8b26a::skull {
    struct SKULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKULL>(arg0, 6, b"SKULL", b"Skull", b"SKULL is a memecoin born with a rebellious and fun spirit, here to shake up the crypto world on the Sui blockchain. Inspired by the iconic skull symbol, representing strength, courage, and individuality, SKULL brings fresh energy to a crypto community craving both entertainment and profit potential.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241115_214736_8039376b83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

