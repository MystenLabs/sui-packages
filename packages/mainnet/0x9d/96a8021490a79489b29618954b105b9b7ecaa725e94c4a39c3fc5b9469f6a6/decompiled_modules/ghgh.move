module 0x9d96a8021490a79489b29618954b105b9b7ecaa725e94c4a39c3fc5b9469f6a6::ghgh {
    struct GHGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHGH>(arg0, 9, b"GHGH", b"LIGHT", b" THE LIGHT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a834c850-f3d5-481b-9cbd-c443f47be95b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

