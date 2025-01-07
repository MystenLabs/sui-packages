module 0xc8da7893207384e222cae678c314e481300d0fd7e30d0749acc2be5b3e4fbeb1::suiiiii {
    struct SUIIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIII>(arg0, 6, b"SUIIIII", b"Suinaldo", b"Suiiiiiiiiiiiiiiiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4156_e566eeae9c_239a43377b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

