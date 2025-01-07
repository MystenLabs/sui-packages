module 0x5ccefa16860ae988b18ac917627f0af85a4497619f9519c390ec1f0161a9f9a7::coolcats {
    struct COOLCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOLCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOLCATS>(arg0, 6, b"COOLCATS", b"CoolCat", b"CoolCat on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cool_cats_07edb0fc0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOLCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOLCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

