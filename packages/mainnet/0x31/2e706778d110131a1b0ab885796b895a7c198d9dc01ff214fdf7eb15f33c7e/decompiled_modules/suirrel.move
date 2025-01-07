module 0x312e706778d110131a1b0ab885796b895a7c198d9dc01ff214fdf7eb15f33c7e::suirrel {
    struct SUIRREL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRREL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRREL>(arg0, 6, b"SUIRREL", b"Suirrel", b"Suirrel is going nuts on movepump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suirrel_71721b283b.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRREL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRREL>>(v1);
    }

    // decompiled from Move bytecode v6
}

