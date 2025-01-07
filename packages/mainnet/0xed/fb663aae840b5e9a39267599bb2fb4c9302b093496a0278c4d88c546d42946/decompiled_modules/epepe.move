module 0xedfb663aae840b5e9a39267599bb2fb4c9302b093496a0278c4d88c546d42946::epepe {
    struct EPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPEPE>(arg0, 9, b"EPEPE", b"Egyptian PEPE", b"Egyptian PEPE is a meme coin on sui inspired by the ancient egyptian cat named PEPE, this is more than just a memecoin to the ancient tradtion. Let egyptian PEPE unite you and your ancient tradions without  forgetting you financially.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/Wk5LVdy/aigen-20240520154847111.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EPEPE>(&mut v2, 800000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPEPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

