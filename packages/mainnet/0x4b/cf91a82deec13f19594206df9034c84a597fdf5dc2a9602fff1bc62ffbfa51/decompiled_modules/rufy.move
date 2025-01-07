module 0x4bcf91a82deec13f19594206df9034c84a597fdf5dc2a9602fff1bc62ffbfa51::rufy {
    struct RUFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUFY>(arg0, 6, b"RUFY", b"SuiRufyOnsui", b"$RUFY Harnesses the Power of cuteness, running into the sea of sui with the power of leaping and sailing the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001466_f22cfba2b9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

