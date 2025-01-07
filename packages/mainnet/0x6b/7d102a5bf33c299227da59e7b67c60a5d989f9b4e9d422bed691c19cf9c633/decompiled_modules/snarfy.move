module 0x6b7d102a5bf33c299227da59e7b67c60a5d989f9b4e9d422bed691c19cf9c633::snarfy {
    struct SNARFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNARFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNARFY>(arg0, 6, b"SNARFY", b"Snarfy", b"Snarfy, a blue aardvark character by Matt Furie.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/icon_1_e3dd4cd375.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNARFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNARFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

