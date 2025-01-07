module 0x49968f153190787af08e39a8a63da4b4db3b34619f9ddeb52d25b1779a84634b::mvc {
    struct MVC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MVC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MVC>(arg0, 6, b"MVC", b"the most vicious chicken", b"The most ferocious, pecking powerful cock the burly will never fall when there are many enemies ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052849_0cfa3a3784.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MVC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MVC>>(v1);
    }

    // decompiled from Move bytecode v6
}

