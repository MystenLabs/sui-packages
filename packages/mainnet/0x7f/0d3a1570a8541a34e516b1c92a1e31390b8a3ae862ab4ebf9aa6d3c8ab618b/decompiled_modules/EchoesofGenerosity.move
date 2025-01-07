module 0x7f0d3a1570a8541a34e516b1c92a1e31390b8a3ae862ab4ebf9aa6d3c8ab618b::EchoesofGenerosity {
    struct ECHOESOFGENEROSITY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECHOESOFGENEROSITY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECHOESOFGENEROSITY>(arg0, 0, b"COS", b"Echoes of Generosity", b"The Aurahma wish you a happy 2022 holiday and new year!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Ears_Echoes_of_Generosity.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ECHOESOFGENEROSITY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECHOESOFGENEROSITY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

