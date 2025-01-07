module 0xa840bd14fd36d5404c49920772eb6839ca4692cc0a751b20ba516a9222a2a919::yap {
    struct YAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAP>(arg0, 6, b"YAP", b"YAPPER", b"\"Hi! I'm Yapper! I'm 8 years old and I love playing video games and riding my scooter.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_16_49_56_4c82dc4614.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

