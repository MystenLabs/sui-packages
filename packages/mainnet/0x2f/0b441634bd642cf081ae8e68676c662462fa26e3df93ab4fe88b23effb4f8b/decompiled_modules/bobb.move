module 0x2f0b441634bd642cf081ae8e68676c662462fa26e3df93ab4fe88b23effb4f8b::bobb {
    struct BOBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBB>(arg0, 6, b"BOBB", b"Bobb", b"$Bobb waited a long time for you, but it wasn't for nothing, good to see you here. Now you will be a part of $bobb's community, but only because he wanted so, but believe me, you will not regret, because $bobb is very generous and always tries to make sure that all his holders were in wealth and in prosperity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm6e_N4_GS_400x400_c987f182a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

