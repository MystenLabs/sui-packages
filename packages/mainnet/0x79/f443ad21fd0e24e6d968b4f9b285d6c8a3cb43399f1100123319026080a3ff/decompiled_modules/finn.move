module 0x79f443ad21fd0e24e6d968b4f9b285d6c8a3cb43399f1100123319026080a3ff::finn {
    struct FINN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINN>(arg0, 6, b"FINN", b"Finn The Sharkoon", b"Finn the trashpanda of the seas, why don u come and swem wit me i gibe protec to anyone ho joins mi flock", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_3adaa25710.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINN>>(v1);
    }

    // decompiled from Move bytecode v6
}

