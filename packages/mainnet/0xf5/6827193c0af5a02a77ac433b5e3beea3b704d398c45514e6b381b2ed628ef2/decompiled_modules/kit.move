module 0xf56827193c0af5a02a77ac433b5e3beea3b704d398c45514e6b381b2ed628ef2::kit {
    struct KIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIT>(arg0, 6, b"Kit", b"Kitty", b"Kitty is a community for cat lovers to connect and celebrate the joy of feline companionship.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fotor_ai_20240829162531_25f5f56385.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

