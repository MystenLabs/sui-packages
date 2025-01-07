module 0x5bafe605cca39fb05e61249e1f2987b37aa5ed4163333f641c7693bb5e0abe80::rai {
    struct RAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAI>(arg0, 9, b"RAI", b"RAIN", b"RAIN is a revolutionary crypto token aimed at harnessing the power of decentralized finance for climate action. With every transaction, RAIN fosters environmental projects, supports renewable energy, and promotes sustainable practices.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/556a73f6-5989-4b64-bd16-55ee1d80f6c9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

