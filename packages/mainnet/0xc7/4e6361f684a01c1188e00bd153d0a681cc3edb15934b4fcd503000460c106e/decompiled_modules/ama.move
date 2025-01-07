module 0xc74e6361f684a01c1188e00bd153d0a681cc3edb15934b4fcd503000460c106e::ama {
    struct AMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMA>(arg0, 9, b"AMA", b"Amanita", b"Just a mushroom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c90df4e5-bf14-4659-9851-34945078dd8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

