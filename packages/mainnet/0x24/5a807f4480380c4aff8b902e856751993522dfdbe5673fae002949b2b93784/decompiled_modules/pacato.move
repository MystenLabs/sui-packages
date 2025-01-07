module 0x245a807f4480380c4aff8b902e856751993522dfdbe5673fae002949b2b93784::pacato {
    struct PACATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACATO>(arg0, 9, b"PACATO", b"Pacato", b"PACATO - Sui  Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x24ca2fcca044b345d0676f770c6cb42ac34809d7.png?size=xl&key=4d7169")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PACATO>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACATO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PACATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

