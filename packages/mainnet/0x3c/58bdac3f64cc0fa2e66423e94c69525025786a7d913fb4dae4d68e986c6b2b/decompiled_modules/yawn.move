module 0x3c58bdac3f64cc0fa2e66423e94c69525025786a7d913fb4dae4d68e986c6b2b::yawn {
    struct YAWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAWN>(arg0, 6, b"YAWN", b"Yawn's World On Sui", b"The crypto world is waking up to $YAWN on the SUI network..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prop_fed0d04092.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

