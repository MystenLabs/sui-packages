module 0x504e550aaea454f504422f94e86191b21a2fb897a6694f80e5d3a4c642138e1a::babypnut {
    struct BABYPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPNUT>(arg0, 6, b"BABYPNUT", b"THE CUTEST TOKEN", b"the cutest token on Sui, featuring an adorable baby squirrel with an endless love for peanuts! Fun, playful, and full of charm, $BABYPNUT invites you to join a nutty community built on joy and connection. Grab your stash and go nuts with $BABYPNUT!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_598ebccb5f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYPNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

