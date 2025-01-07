module 0x95f57762ea33eac817d3444f40b74489d6b5b684fb4ba768308811445d5b24c4::arjm3 {
    struct ARJM3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARJM3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARJM3>(arg0, 9, b"ARJM3", b"Arj", b"The meme for project green energy to thw word", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ecdc6d4c-d25a-41e3-9690-d137379c7f30.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARJM3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARJM3>>(v1);
    }

    // decompiled from Move bytecode v6
}

