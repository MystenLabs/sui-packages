module 0x8ded79c42a9d9d4a02d5c66903b35a5629a2bde1342b505017b405fbe98489c6::dropc {
    struct DROPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROPC>(arg0, 9, b"DROPC", b"DropsCoin", b"drop coin trading - wewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df7a83a9-ec59-422f-8853-5a98030ff432.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DROPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

