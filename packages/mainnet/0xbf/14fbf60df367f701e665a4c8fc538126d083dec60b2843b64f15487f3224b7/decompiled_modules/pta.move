module 0xbf14fbf60df367f701e665a4c8fc538126d083dec60b2843b64f15487f3224b7::pta {
    struct PTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTA>(arg0, 9, b"PTA", b"Puttotalk", b"Put to talk or silen to die", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee1bc99e-3ea1-4dca-9787-cfaabef0e464.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

