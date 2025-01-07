module 0xd06eaab87b28df8b3de0a132de8343f6de3cb408beb820ba5730ec0363992a16::bully {
    struct BULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BULLY>(arg0, 6, b"BULLY", b"Dolos the Bully", b"your favorite Bully. ancient villain reborn.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000130767_216c3c3e5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULLY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

