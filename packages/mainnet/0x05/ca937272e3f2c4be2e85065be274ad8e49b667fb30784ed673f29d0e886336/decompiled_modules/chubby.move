module 0x5ca937272e3f2c4be2e85065be274ad8e49b667fb30784ed673f29d0e886336::chubby {
    struct CHUBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUBBY>(arg0, 6, b"CHUBBY", b"CUTE CHUBBY", b"#CHUBBY is the cutest and most adorable memecoin in the SUI network. He symbolizes stability and reliabilityafter all, who better than a hippo knows how to stay afloat? Let every CHUBBY token bring you a smile and luck! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logos_a1eb507e06.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

