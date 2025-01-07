module 0xd44240981ed86855ddab9270d293e377ee86e173f928f30edf940a66f332f459::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 6, b"Suidog", b"Kufu", b"where the power of a tsunami meets the playful spirit of a surf-loving Shiba Inu. This isn't just another token; it's a tidal wave of innovation on the Sui Blockchain. Surfing through the crypto market with unparalleled speed and agility, $suidog represents the force of nature in the world of digital currency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022052_2f65951d02.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

