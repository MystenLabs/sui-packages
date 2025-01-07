module 0x55e4fa2693a16bb88ff8ec66af2c4778e23174f759094bcc2e7a7b9861d57c89::srump {
    struct SRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRUMP>(arg0, 9, b"SRUMP", b"TRUMP", b"BUY FOR ESCAPE MATRIX .BE THE OG FUCKING MILLIONAIRE. TRUMP COIN HAS GREAT FUTURE NOT FINANCIAL ADVICE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0848c44c-456c-4781-af9c-590ffec68f12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

