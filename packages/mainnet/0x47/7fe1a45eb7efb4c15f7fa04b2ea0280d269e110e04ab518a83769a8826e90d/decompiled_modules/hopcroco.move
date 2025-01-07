module 0x477fe1a45eb7efb4c15f7fa04b2ea0280d269e110e04ab518a83769a8826e90d::hopcroco {
    struct HOPCROCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPCROCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPCROCO>(arg0, 6, b"HOPCROCO", b"Hopcoroco On Sui", b"Croco is a unique memecoin built on the Sui blockchain, designed to bring together cryptocurrency enthusiasts. Our community thrives on humor and innovation, making crypto accessible and enjoyable for everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001683_d94443bdab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPCROCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPCROCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

