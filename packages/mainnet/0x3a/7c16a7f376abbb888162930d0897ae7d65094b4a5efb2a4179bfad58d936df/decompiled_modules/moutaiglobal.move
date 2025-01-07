module 0x3a7c16a7f376abbb888162930d0897ae7d65094b4a5efb2a4179bfad58d936df::moutaiglobal {
    struct MOUTAIGLOBAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOUTAIGLOBAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOUTAIGLOBAL>(arg0, 6, b"MoutaiGlobal", b"Moutai", x"57656c636f6d6520746f200a404d6f75746169476c6f62616c0a206f6666696369616c20547769747465722070616765210a4d6f75746169204368696e612c206120746f61737420746f2074686520776f726c6421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Y_Io_C3ao_400x400_aad6a7887c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOUTAIGLOBAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOUTAIGLOBAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

