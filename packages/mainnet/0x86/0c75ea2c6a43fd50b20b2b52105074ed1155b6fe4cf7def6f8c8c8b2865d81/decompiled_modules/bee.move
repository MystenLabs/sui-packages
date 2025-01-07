module 0x860c75ea2c6a43fd50b20b2b52105074ed1155b6fe4cf7def6f8c8c8b2865d81::bee {
    struct BEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEE>(arg0, 6, b"BEE", b"Bee of Sui", b"Busy and buzzing, $BEE pollinates the Sui Network with sweet opportunities. Its all about building the hive and stacking that honey. Join the swarm!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_71_a244f63ef8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

