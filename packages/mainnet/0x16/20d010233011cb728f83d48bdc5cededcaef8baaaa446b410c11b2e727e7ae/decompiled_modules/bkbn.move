module 0x1620d010233011cb728f83d48bdc5cededcaef8baaaa446b410c11b2e727e7ae::bkbn {
    struct BKBN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKBN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BKBN>(arg0, 9, b"BKBN", b"Bakabon", b"Meme roken for genius Bakabon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d850d8ee-bb61-4cb7-af07-a9e7c01a18c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKBN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BKBN>>(v1);
    }

    // decompiled from Move bytecode v6
}

