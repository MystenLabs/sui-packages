module 0x175b1abdfc51e1708fc7efedc20ce25b08d85e7cfc5cfba98220f1f33a4682c1::etank {
    struct ETANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETANK>(arg0, 6, b"eTANK", b"ELECTRIC TANK", b"NOW TANKS PROTECT THE ENVIRONMENT INSTEAD OF DESTROYING IT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Diseno_sin_titulo_6_removebg_preview_48c37915d1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETANK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETANK>>(v1);
    }

    // decompiled from Move bytecode v6
}

