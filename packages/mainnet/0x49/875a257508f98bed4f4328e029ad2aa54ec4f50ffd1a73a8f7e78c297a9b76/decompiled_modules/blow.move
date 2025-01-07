module 0x49875a257508f98bed4f4328e029ad2aa54ec4f50ffd1a73a8f7e78c297a9b76::blow {
    struct BLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOW>(arg0, 6, b"BLOW", b"Blow", b"Just a pure pleasure!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blowjob_650f3357bc.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

