module 0x37b8aadb929f4dbfe67e01afc7cba3882ed292b22353dd2c0df76062fee47fb7::sfa {
    struct SFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFA>(arg0, 6, b"SFA", b"SUIOFA", b"Chill on your Sui-ofa and watch your investments flow. Relax as the market grows, powered by the fluidity of water and the strength of innovation.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000005662_d1282b3325.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

