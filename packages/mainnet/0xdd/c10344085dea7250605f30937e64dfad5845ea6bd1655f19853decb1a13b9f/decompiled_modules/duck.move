module 0xddc10344085dea7250605f30937e64dfad5845ea6bd1655f19853decb1a13b9f::duck {
    struct DUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 6, b"DUCK", b"DUCK On SUI", b"Dive into the Sui ecosystem with Duck Coin, the playful and unpredictable memecoin ready to ruffle some feathers. Join the flock and experience the thrill of decentralized finance with a side of quackers!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/duck_logo_ac6ccd8a04.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

