module 0xd693392eb7ceb88e1271dc9da5e7edb535f7230f99b386039d0482aed77e7231::shibu {
    struct SHIBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBU>(arg0, 6, b"SHIBU", b"Shibu Doge Puppets", x"426f726e20746f20437265617465200a536869627520446f676520507570706574732020417574686f722020496c6c7573747261746f7220204d656d6573202041492041727420204e46410a204d61646520696e204672616e6365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ej_Lm_R_Ag_400x400_810b67f841.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

