module 0x911be3acfe07c0b3f9217988ff0b173511a5e0747fafa2fd9c70d8a0887d5f2b::choctopus {
    struct CHOCTOPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOCTOPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOCTOPUS>(arg0, 6, b"CHOCTOPUS", b"Choctopusui", b"Half Chocolate Lab + Half Octopus = $CHOCTOPUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003647_58514d248d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOCTOPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOCTOPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

