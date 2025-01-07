module 0xf1c5f487b77b4dbe9344af3420ba0f714f47a7b63eff04e218bbef5f6399b78a::dss {
    struct DSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSS>(arg0, 6, b"DSS", b"Dead Skull Society", b"Preseason Sui Skulls Join the Society & be rewarded!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/H240_Qtwu_400x400_045b1b2cdd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

