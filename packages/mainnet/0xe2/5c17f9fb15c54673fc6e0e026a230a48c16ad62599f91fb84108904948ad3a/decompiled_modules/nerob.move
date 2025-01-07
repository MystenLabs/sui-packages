module 0xe25c17f9fb15c54673fc6e0e026a230a48c16ad62599f91fb84108904948ad3a::nerob {
    struct NEROB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEROB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEROB>(arg0, 6, b"NEROB", b"BABYNEROSUI", x"69207761732028726529626f726e20696e20746865207472656e636865732e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6lb_NQ_Ys_G_400x400_083b2dbca7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEROB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEROB>>(v1);
    }

    // decompiled from Move bytecode v6
}

