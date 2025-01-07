module 0x9132801d1f7b313649ecfc46c2a3c9fa36a5121643024e54d34a4e69a0502f5e::sdn {
    struct SDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDN>(arg0, 6, b"SDN", b"Suidon", b"Suidon : movepump launch no jutsu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiton_image_2ed389ebd7_b17499e575.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

