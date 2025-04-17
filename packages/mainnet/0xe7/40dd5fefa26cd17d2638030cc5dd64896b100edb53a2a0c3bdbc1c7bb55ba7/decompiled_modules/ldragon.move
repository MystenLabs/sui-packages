module 0xe740dd5fefa26cd17d2638030cc5dd64896b100edb53a2a0c3bdbc1c7bb55ba7::ldragon {
    struct LDRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LDRAGON>(arg0, 6, b"LDRAGON", b"LitchDragon", b"$LDRAGON - Is an adorable little dragon, born in the sui network and has hidden mysterious powers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000059053_4d66fb8805.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LDRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

