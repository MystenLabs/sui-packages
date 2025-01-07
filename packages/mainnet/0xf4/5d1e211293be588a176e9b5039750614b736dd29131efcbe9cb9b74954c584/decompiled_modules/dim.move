module 0xf45d1e211293be588a176e9b5039750614b736dd29131efcbe9cb9b74954c584::dim {
    struct DIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIM>(arg0, 6, b"DIM", b"Dog in Mask", b"I'm Dim - You didn't see me!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DIM_777_e663deab02.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

