module 0xdc904c2d61f93389ee14ed76d95e9ffd552fdce4e2f403d9d321ca8aa7a8f2b::papa {
    struct PAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPA>(arg0, 6, b"PAPA", b"papa", x"74686520676f64666174686572206f66206d656d65730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731445401715.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

