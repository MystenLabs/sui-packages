module 0x46b23e546c28828ac0f4cd3b8b2e5bfb159eef16038ddce01e22825ca3b01a0e::ghgh {
    struct GHGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHGH>(arg0, 9, b"GHGH", b"BRIDGE ", b"A BRIDGE FULL OF FLOWERS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/52d43f03-1eb4-4f0f-9e20-4daf8b126949.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

