module 0x1210fa82b2b304648310ae7a5aa36162a94320dae8a6516b2ca106f8c7ad5438::pluff {
    struct PLUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUFF>(arg0, 6, b"PLUFF", b"Pluff", b"PLUFF is the silent hero of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pluff_e09ad21a36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

