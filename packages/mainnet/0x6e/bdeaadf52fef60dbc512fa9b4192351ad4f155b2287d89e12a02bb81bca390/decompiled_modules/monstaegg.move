module 0x6ebdeaadf52fef60dbc512fa9b4192351ad4f155b2287d89e12a02bb81bca390::monstaegg {
    struct MONSTAEGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONSTAEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONSTAEGG>(arg0, 6, b"MonstaEgg", b"Monsta Egg on SUI - the series", b"Have you ever seen an egg in the sea? Of course not. That's because the egg monster is only found 10,973 meters below sea level. Take care of this egg as time goes by, something BIGG IS CUMIN!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/istockphoto_981076040_612x612_9d549d6b48.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONSTAEGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONSTAEGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

