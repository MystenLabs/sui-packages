module 0xd96a94a6e121a28b4ff669d3d655480277efc5658d09ceef222417768a1918e3::pshot {
    struct PSHOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSHOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSHOT>(arg0, 6, b"PShot", b"Peanut the Luigi", b"Villain or Hero? If the token graduates he is a hero", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733812240633.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSHOT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSHOT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

