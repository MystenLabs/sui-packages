module 0xd0f3e4136efff0505445ee853130b8b8afe9cd5d0ab140f4c723a6cb4335fc65::suipe {
    struct SUIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPE>(arg0, 6, b"SUIPE", b"Sui Pepe", b"Meet $SUIPE, the shark will thats making waves in the crypto ocean! . This isnt just another meme coin$SUIPE is a bold new player ready to shake up the crypto waters. With a cheeky grin and a sleek fin, $SUIPE swims through the market with confidence, making waves and snatching up gains. With a community-driven spirit and a hunger for success, this shark is ready to chomp through the competition and leave its mark on the crypto scene. Swim with $SUIPE and ride the wave to the top! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SHAPE_98783d5d71.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

