module 0xf256a915304e7e28dc72fe7ce004d44242bdc1c5fcc63f74a963fa9925aa10ad::autism {
    struct AUTISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUTISM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUTISM>(arg0, 6, b"AUTISM", b"Autistic Penguin", b"Just a Penguin with Autism", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/autistic_penguin_ec280969ac.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUTISM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUTISM>>(v1);
    }

    // decompiled from Move bytecode v6
}

