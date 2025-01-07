module 0x466e7264586565a4d892eb203691d2b8174b26ca00743e8af477c8e9f683b049::mds {
    struct MDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDS>(arg0, 6, b"MDS", b"MooDengSui", b"Welcome to the Moo Deng so cute project, we have plan to be the cutest Hipopotamo of all Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hipopo_83e2c20372.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

