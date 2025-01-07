module 0x637e5565cdc88e1d323907862401bbc638d5b4fe8fa4cdb1a27fdb9f3e485228::tadpole {
    struct TADPOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TADPOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TADPOLE>(arg0, 6, b"TADPOLE", b"Tadpole the Frogfish", b"The most famous fish in the world! https://www.tiktok.com/@tadpolethefrogfish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tad_b056f0eab1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TADPOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TADPOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

