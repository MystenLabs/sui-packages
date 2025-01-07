module 0x9921cc340bdd85f7109853923c570c998290d96f541caab219bf9526eac0cf27::dot2 {
    struct DOT2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOT2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOT2>(arg0, 6, b"DOT2", b"Polkadot 2.0", b"This is for all the people that are in the red with $DOT and want a shot at winning big. Devs hold 1%, this is a fair launch coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Polkadot_Bull_0a01075f99.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOT2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOT2>>(v1);
    }

    // decompiled from Move bytecode v6
}

