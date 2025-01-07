module 0xe4b98204044d9f85789a24075d4b3848ead24a38922bf18b9bb05156935f601c::frogg {
    struct FROGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGG>(arg0, 9, b"FROGG", b"FROG", b"THIS A FROG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3eadddf-1604-4da4-ad06-d42e0cf8aa75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

