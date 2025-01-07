module 0x7b915c5b77c1ead1f7837ceaf6eeeb2049d55f67d9f9182337542dd31c9fa2ff::suisung {
    struct SUISUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISUNG>(arg0, 6, b"SUISUNG", b"SUISUNG GLX", b"Inspire the World, Create the Future...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_40_c90f5d2d23.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISUNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISUNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

