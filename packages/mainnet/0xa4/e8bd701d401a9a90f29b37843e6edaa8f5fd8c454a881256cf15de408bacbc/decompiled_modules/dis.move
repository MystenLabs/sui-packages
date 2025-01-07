module 0xa4e8bd701d401a9a90f29b37843e6edaa8f5fd8c454a881256cf15de408bacbc::dis {
    struct DIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIS>(arg0, 6, b"DIS", b"Diddy on the SUI", b"Here is the Party of Diddy, welcome guys!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8tw_Y_Fo_B2_400x400_a9215a3e1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

