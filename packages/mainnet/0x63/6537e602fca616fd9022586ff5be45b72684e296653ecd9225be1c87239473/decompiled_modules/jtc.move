module 0x636537e602fca616fd9022586ff5be45b72684e296653ecd9225be1c87239473::jtc {
    struct JTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JTC>(arg0, 6, b"JTC", b"Jimmy The Condom", b"Stop blowing your chance at the next big thing! Jimmy The Condom Meme is here to provide security, laughs, and potentially massive gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_28_064333_569ba622bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

