module 0x61acb5b05e0475563d100576a2a3163992b1c1f7c4170f004a442ee8f00b6d2f::niggabutt {
    struct NIGGABUTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGABUTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGABUTT>(arg0, 6, b"NiggaButt", b"Nigga Butt Token", b"fuck to the moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/111_af6841f1c5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGABUTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGABUTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

