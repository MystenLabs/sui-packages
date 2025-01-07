module 0x86d05e3f779261e5570d16ced5aae34156ef5f859dd9f546ed02190dcd8dd959::ctc {
    struct CTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTC>(arg0, 9, b"CTC", b"Catiac", b"Catiac token is memetoken in sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec56bfb9-9ce4-4c33-b077-8de39b30e068.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

