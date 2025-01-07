module 0x251f5b82036ae44542bb643a5822388adba689db2e0afad4b9efa958ea79fdd5::shiv {
    struct SHIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIV>(arg0, 9, b"SHIV", b"Shiva", b"Utility and digital asset", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/119f7c31-b406-42bb-b0b1-e108dac01c9a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIV>>(v1);
    }

    // decompiled from Move bytecode v6
}

