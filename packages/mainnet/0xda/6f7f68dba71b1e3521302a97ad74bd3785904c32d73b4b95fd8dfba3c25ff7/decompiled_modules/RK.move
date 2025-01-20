module 0xda6f7f68dba71b1e3521302a97ad74bd3785904c32d73b4b95fd8dfba3c25ff7::RK {
    struct RK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RK>(arg0, 6, b"RK", b"RK", b"RK token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://de.fi/test.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

