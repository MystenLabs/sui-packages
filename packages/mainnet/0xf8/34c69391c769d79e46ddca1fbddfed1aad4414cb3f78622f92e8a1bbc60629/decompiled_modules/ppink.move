module 0xf834c69391c769d79e46ddca1fbddfed1aad4414cb3f78622f92e8a1bbc60629::ppink {
    struct PPINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPINK>(arg0, 6, b"PPINK", b"PepePinkOnSui", b"Make your life full of pink,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241006_025451_23bcf7beb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

