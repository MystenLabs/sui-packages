module 0xee8f8e64a3bd144f69e36bb3e4eb595b4876af83a5e917dafe7a415af6759fd4::mdr {
    struct MDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDR>(arg0, 9, b"MDR", b"Mandiraja", b"Island of banjarnegara", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f5a52fcf-cb1f-44f0-b4fd-e5b5889771ca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

