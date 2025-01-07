module 0x44641093c1c892983c208a3b2a466950b1ae3c00b2882df2ee625d201160a194::tipsy {
    struct TIPSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIPSY>(arg0, 6, b"TIPSY", b"TIPSY COMUNITY", b"CTO TIPSY : A spirited narwhal named Tipsy runs a blockchain start-up called \"MOVEPUMP.\" Every time someone invests in his coin, he takes a celebratory chug of beer.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tripsy_3b679ebb5d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIPSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIPSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

