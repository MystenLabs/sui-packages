module 0xf512c38e6bf83f810d0b8dbefeae55658c01163ffa512ce7b911be3ea9586004::prump {
    struct PRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRUMP>(arg0, 6, b"PRUMP", b"The Trump Pepe", b"PRUMP - The Trump Pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_ec763db6a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

