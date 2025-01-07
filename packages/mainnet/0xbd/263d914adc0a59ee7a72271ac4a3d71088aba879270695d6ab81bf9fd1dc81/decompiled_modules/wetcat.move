module 0xbd263d914adc0a59ee7a72271ac4a3d71088aba879270695d6ab81bf9fd1dc81::wetcat {
    struct WETCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WETCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETCAT>(arg0, 6, b"WETCAT", b"cat is wet", b"cat is wet on waterchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_water_96039e8e72.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WETCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

