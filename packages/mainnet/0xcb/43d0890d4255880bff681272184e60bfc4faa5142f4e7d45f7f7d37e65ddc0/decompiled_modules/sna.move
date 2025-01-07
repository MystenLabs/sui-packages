module 0xcb43d0890d4255880bff681272184e60bfc4faa5142f4e7d45f7f7d37e65ddc0::sna {
    struct SNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNA>(arg0, 9, b"SNA", b"Swarm Node AI", b"Serverless infra for AI agents", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmf978WVwJWAjeJaJY5jGiZ3YEdQgC43Cn4QowytAYos78")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SNA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

