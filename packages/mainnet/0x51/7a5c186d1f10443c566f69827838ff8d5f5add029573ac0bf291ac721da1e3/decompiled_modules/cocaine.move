module 0x517a5c186d1f10443c566f69827838ff8d5f5add029573ac0bf291ac721da1e3::cocaine {
    struct COCAINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCAINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCAINE>(arg0, 6, b"COCAINE", b"CocaineHorse Sui", b"A dr*gged horse coz life is hard", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000437_260b144068.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCAINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCAINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

