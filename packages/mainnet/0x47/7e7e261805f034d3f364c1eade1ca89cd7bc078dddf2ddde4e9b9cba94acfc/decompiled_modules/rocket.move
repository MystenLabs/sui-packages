module 0x477e7e261805f034d3f364c1eade1ca89cd7bc078dddf2ddde4e9b9cba94acfc::rocket {
    struct ROCKET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKET>(arg0, 6, b"ROCKET", b"TEAM ROCKET", b"Relaunch. Team Rocket forged on the sui network. Get in early.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie2hbjhrkqrewe4jcg65pb2bdwchzsju4ppdwvrn6szju663txov4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROCKET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

