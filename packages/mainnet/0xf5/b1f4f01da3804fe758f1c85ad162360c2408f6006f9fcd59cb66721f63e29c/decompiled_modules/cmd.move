module 0xf5b1f4f01da3804fe758f1c85ad162360c2408f6006f9fcd59cb66721f63e29c::cmd {
    struct CMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMD>(arg0, 6, b"CMD", b"Comedian", b"Comedian is a 2019 artwork by Italian artist Maurizio Cattelan. Created in an edition of three, it appears as a fresh banana affixed to a wall with duct tape. As a work of conceptual art, it consists of a certificate of authenticity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732471462976.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CMD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

