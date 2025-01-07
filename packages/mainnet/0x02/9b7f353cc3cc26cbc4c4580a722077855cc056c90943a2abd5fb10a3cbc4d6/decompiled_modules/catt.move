module 0x29b7f353cc3cc26cbc4c4580a722077855cc056c90943a2abd5fb10a3cbc4d6::catt {
    struct CATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATT>(arg0, 9, b"CATT", b"CCA", b"CCAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9f557ca-b5fc-4424-87f0-0d9e458b2388.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

