module 0xa7766876e9a141fc950ef8f94147fe743629bcfa56ed874d642460cd5d69da68::ath {
    struct ATH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATH>(arg0, 6, b"ATH", b"It's fcking ATH BABE~", b"LET'S GOOOO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ds_f527ba15e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATH>>(v1);
    }

    // decompiled from Move bytecode v6
}

