module 0x10ceb2c5f51deee440fab8eba58fd1bf32b576d7563a7fbd690b85762c9102a9::finn {
    struct FINN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINN>(arg0, 6, b"FINN", b"Finn the Ferret", b"Meet Finn, the fearless mischievous explorer on SuiNetwork. Finn moves fast. He's not waiting, and neither should you. Act now, before it's too late.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_23_668adbff2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINN>>(v1);
    }

    // decompiled from Move bytecode v6
}

