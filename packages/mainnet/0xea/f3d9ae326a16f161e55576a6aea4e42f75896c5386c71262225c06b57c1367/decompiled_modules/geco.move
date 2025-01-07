module 0xeaf3d9ae326a16f161e55576a6aea4e42f75896c5386c71262225c06b57c1367::geco {
    struct GECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GECO>(arg0, 6, b"GECO", b"GECO SUI", b"First Matt Furie's Meme coin on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000117281_c08105652c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GECO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GECO>>(v1);
    }

    // decompiled from Move bytecode v6
}

