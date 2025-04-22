module 0x54f77c73c5276a943aeedb1c78eda3786a57e06ebcf1966a18f0f0ac724b2cfe::mdg {
    struct MDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDG>(arg0, 6, b"MDG", b"MooG DoG", b"Brewer of the Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001668001_109ef7ae10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

