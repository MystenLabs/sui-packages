module 0x9656a1f084fb6df5b7ca5b90e179918b1de306a28d92b435a20f10b3058865e0::flx {
    struct FLX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLX>(arg0, 6, b"FLX", b"FELIX ON SUI", b"The Feisty Feline | on SUI - ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dubo_fwog_gm_710d99aea4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLX>>(v1);
    }

    // decompiled from Move bytecode v6
}

