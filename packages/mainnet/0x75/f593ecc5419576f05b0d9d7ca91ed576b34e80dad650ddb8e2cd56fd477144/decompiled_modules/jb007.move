module 0x75f593ecc5419576f05b0d9d7ca91ed576b34e80dad650ddb8e2cd56fd477144::jb007 {
    struct JB007 has drop {
        dummy_field: bool,
    }

    fun init(arg0: JB007, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JB007>(arg0, 6, b"JB007", b"Agent007", b"I'm James Bond but people know me like AGENT 007!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jmb_3cc2bcb593.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JB007>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JB007>>(v1);
    }

    // decompiled from Move bytecode v6
}

