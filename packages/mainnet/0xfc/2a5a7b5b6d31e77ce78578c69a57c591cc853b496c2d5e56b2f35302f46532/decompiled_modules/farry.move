module 0xfc2a5a7b5b6d31e77ce78578c69a57c591cc853b496c2d5e56b2f35302f46532::farry {
    struct FARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARRY>(arg0, 6, b"FARRY", b"Farry", b"It's time for farry to take over, the frog memecoin that has a strong authority", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058369_6e2a007beb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

