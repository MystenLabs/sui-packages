module 0x1e6263b19b8259ec2204ae9da872ae13deec19da9f1661ef627ca246352ca0c4::dnsr {
    struct DNSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNSR>(arg0, 6, b"DNSR", b"DINOSAUR", b"just a digital art of dinosaur sculpture carved on mountain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8625_1_27f443a4a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNSR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

