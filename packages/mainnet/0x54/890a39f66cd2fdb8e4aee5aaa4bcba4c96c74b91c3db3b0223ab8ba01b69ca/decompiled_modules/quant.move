module 0x54890a39f66cd2fdb8e4aee5aaa4bcba4c96c74b91c3db3b0223ab8ba01b69ca::quant {
    struct QUANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUANT>(arg0, 6, b"QUANT", b"QUANT on SUI", b"Gen Z QUANT on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Y5_VG_Gb4_Q_400x400_779d2ad8cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

