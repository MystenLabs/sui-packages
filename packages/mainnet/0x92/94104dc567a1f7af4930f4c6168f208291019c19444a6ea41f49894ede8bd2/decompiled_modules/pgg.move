module 0x9294104dc567a1f7af4930f4c6168f208291019c19444a6ea41f49894ede8bd2::pgg {
    struct PGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGG>(arg0, 9, b"PGG", b"PiggiLand", b"MomoAI PiggyLand", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d7c16e9a-278b-47fa-b674-ddfa76574aa9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

