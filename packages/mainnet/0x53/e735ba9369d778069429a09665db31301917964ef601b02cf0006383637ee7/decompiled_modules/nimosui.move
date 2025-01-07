module 0x53e735ba9369d778069429a09665db31301917964ef601b02cf0006383637ee7::nimosui {
    struct NIMOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIMOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIMOSUI>(arg0, 6, b"NIMOSUI", b"nimosui", b"cute nimo will go dex..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012336_baefc56f24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIMOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIMOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

