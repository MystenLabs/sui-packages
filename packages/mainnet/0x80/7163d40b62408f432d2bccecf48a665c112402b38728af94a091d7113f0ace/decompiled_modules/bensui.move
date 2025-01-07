module 0x807163d40b62408f432d2bccecf48a665c112402b38728af94a091d7113f0ace::bensui {
    struct BENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENSUI>(arg0, 6, b"BENSUI", b"Benson Sui", b"Benson Dunwoody: The iconic living gumbal machine the runs a park", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016570_951f6c7c6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

