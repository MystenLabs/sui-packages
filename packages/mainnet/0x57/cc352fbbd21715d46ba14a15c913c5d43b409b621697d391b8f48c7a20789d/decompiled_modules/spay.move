module 0x57cc352fbbd21715d46ba14a15c913c5d43b409b621697d391b8f48c7a20789d::spay {
    struct SPAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAY>(arg0, 9, b"SPAY", b"SuiPay", b"Sui fun meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa653a3a-541c-4de3-92eb-7fce5ff7888d-IMG_20240818_200113_489.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

