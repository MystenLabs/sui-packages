module 0x87da4af4ea6a890a49ca57e1c9044c5824bb14c446b7332e6fc961ce45fc5dc4::rug {
    struct RUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUG>(arg0, 6, b"Rug", b"Rugpull", b"The ticker is Rug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5662_b12ac8e0db.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

