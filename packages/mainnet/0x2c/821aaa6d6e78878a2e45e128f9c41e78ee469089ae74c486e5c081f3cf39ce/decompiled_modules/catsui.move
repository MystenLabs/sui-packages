module 0x2c821aaa6d6e78878a2e45e128f9c41e78ee469089ae74c486e5c081f3cf39ce::catsui {
    struct CATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSUI>(arg0, 6, b"Catsui", b"CatSui", b"Full degen power of the samurai cat meme coin! With its playful charm and fierce spirit, Catsui is here to dominate the crypto scene. Dive into a world of fun and chaos, where meme culture meets Japanese aesthetics. Join the Catsui army and ride the wave of this unstoppable feline force! Get in, hold tight, and let the moon mission begin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6510_CB_3_D_2_A41_4784_852_E_0_E552_C606164_321cb8d685.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

