module 0xf5822ec946e53987e83ba2d93f49a27a324aba800a8337574f871473b425dfe9::OVO {
    struct OVO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OVO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OVO>(arg0, 9, b"OVO", b"OVO", b"$OVO is your best chance to get your money up like Drizzy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746966422129958912/hoklBCza_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OVO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OVO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OVO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OVO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

