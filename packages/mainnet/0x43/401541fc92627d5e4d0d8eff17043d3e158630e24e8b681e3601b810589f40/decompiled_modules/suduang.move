module 0x43401541fc92627d5e4d0d8eff17043d3e158630e24e8b681e3601b810589f40::suduang {
    struct SUDUANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDUANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDUANG>(arg0, 6, b"SUDUANG", b"Suduang", b"Hippopotamus at Khon Kaen Zoo THAILAND", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_3490fbd2bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDUANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUDUANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

