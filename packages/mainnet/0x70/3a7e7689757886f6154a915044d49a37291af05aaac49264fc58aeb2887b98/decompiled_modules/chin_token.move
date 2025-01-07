module 0x703a7e7689757886f6154a915044d49a37291af05aaac49264fc58aeb2887b98::chin_token {
    struct CHIN_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIN_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIN_TOKEN>(arg0, 9, b"CHIN_TOKEN", b"Jessychin ", b"Greatest of all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a7686bc3-3854-4969-93e1-55aff2cc5d0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIN_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHIN_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

