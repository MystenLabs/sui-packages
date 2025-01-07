module 0x9b4a34d2e87482b4d2889504b2b9d7928cf465ebae1d2aa3cca9c4e8b7032b0c::csmirk {
    struct CSMIRK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSMIRK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSMIRK>(arg0, 9, b"CSMIRK", b"CAT SMIRK", b"CAT SMIRKS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf08cd66-e8e5-4dd4-a4ec-9d6b64a10f80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSMIRK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSMIRK>>(v1);
    }

    // decompiled from Move bytecode v6
}

