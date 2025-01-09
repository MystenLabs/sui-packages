module 0xfff229105ba2b79e889036e460cdfbaff4f965b9f7815b9f54f66a97eca9cab0::russiandogwifhat {
    struct RUSSIANDOGWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSSIANDOGWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSSIANDOGWIFHAT>(arg0, 6, b"RUSSIANDOGWIFHAT", b"DON'T BUY JOIN THE REAL 1st", b"Don't buy this just join the real cto make dev cry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009998_c184f71e04.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSSIANDOGWIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSSIANDOGWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

