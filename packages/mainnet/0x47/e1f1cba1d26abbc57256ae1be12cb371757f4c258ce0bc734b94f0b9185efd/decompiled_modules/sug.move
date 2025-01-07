module 0x47e1f1cba1d26abbc57256ae1be12cb371757f4c258ce0bc734b94f0b9185efd::sug {
    struct SUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUG>(arg0, 6, b"SUG", b"Seal Pug", b"Its not a pug... its not a seal... its a Sug!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sug_4a47e06dc4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

