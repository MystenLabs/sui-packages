module 0x4926b2916f844e784958fa55c57068db0e644473f7d3b91a2f15d09cf1913bfa::wsui {
    struct WSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSUI>(arg0, 6, b"wSUI", b"Wrapped Sui", x"535549206d61726b65746361702031312062696c6c696f6e0a0a5772617070656420537569206d61726b657463617020326b0a0a596f7520617265206561726c7920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3513_2da5355cb2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

