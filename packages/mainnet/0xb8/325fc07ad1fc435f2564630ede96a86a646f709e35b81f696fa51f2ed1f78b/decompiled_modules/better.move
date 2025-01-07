module 0xb8325fc07ad1fc435f2564630ede96a86a646f709e35b81f696fa51f2ed1f78b::better {
    struct BETTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETTER>(arg0, 9, b"BETTER", b"Buffer", b"It keeps getting better as the journey progresses", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b04aff0c-e5b6-453b-9337-422ff2f4a7cd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BETTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

