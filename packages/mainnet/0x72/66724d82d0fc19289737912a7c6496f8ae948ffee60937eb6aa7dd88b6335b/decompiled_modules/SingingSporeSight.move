module 0x7266724d82d0fc19289737912a7c6496f8ae948ffee60937eb6aa7dd88b6335b::SingingSporeSight {
    struct SINGINGSPORESIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINGINGSPORESIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINGINGSPORESIGHT>(arg0, 0, b"COS", b"Singing Spore Sight", b"Crawl deeper into yourself... emerge... as... something... else...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Eyes_Singing_Spore_Sight.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SINGINGSPORESIGHT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINGINGSPORESIGHT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

