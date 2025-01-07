module 0x1cdcf8cea5769659d3f534e347ae5bb3c25b4df33d24817aada83c751da31ee4::suito {
    struct SUITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITO>(arg0, 6, b"SUITO", b"SUITO SHARK", b"SUITO is the official funny shark on SUI who loves to have a drink or two.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suito_ee121cb940.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

