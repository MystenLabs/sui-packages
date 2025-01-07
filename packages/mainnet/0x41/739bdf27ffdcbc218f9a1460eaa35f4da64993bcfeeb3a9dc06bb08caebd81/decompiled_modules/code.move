module 0x41739bdf27ffdcbc218f9a1460eaa35f4da64993bcfeeb3a9dc06bb08caebd81::code {
    struct CODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CODE>(arg0, 6, b"CODE", b"Code for Privacy Not for Punishment", b"symbolizes the importance of privacy in technology and serves as a rallying point for developers and advocates of digital freedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tornado_b1d8127395.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CODE>>(v1);
    }

    // decompiled from Move bytecode v6
}

