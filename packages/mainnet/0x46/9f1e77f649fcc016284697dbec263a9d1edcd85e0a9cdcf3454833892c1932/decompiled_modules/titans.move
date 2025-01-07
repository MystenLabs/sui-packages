module 0x469f1e77f649fcc016284697dbec263a9d1edcd85e0a9cdcf3454833892c1932::titans {
    struct TITANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITANS>(arg0, 6, b"TITANS", b"TITANS ON SUI", b"were a team united by trust, loyalty, and a shared mission. Whether its fighting villains or building something extraordinary, were always in sync. Now, were inviting you to be part of our story. Suit up  the Tower awaits.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kmi_Y_V_Qb_400x400_808331b699.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITANS>>(v1);
    }

    // decompiled from Move bytecode v6
}

