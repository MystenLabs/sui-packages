module 0x69a76e82725a8ee80e1bd73772b9928215965a24a7ac21218de78935a4ecc978::bd {
    struct BD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BD>(arg0, 6, b"BD", b"Blockchain Daily", b"Blockchain Daily  Fans!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20241121090732_5ba4b1734d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BD>>(v1);
    }

    // decompiled from Move bytecode v6
}

