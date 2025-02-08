module 0x398ab3c926e8ed4b819e4bc154f8003d85b73ac8d216e8b4dd37393112adf66c::redninja {
    struct REDNINJA has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDNINJA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDNINJA>(arg0, 6, b"REDNINJA", b"Red Ninja", b"The commemorative memecoin for America's most beloved cat, The Red Ninja.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Red_Ninja_77ea0f939e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDNINJA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDNINJA>>(v1);
    }

    // decompiled from Move bytecode v6
}

