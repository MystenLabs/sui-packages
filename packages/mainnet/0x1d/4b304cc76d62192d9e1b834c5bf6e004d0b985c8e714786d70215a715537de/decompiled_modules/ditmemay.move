module 0x1d4b304cc76d62192d9e1b834c5bf6e004d0b985c8e714786d70215a715537de::ditmemay {
    struct DITMEMAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DITMEMAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DITMEMAY>(arg0, 9, b"DITMEMAY", b"DIT ME MAY", b"Meme number one vn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c85daa9-abdc-4ff6-94cf-dce64806558f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DITMEMAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DITMEMAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

