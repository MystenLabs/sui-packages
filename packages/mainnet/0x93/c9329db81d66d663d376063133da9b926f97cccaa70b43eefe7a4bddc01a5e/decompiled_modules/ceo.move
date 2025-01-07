module 0x93c9329db81d66d663d376063133da9b926f97cccaa70b43eefe7a4bddc01a5e::ceo {
    struct CEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CEO>(arg0, 6, b"CEO", b"Evan CEO Cheng", b"The CEO of Mysten Labs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008952_ef15f7722a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

