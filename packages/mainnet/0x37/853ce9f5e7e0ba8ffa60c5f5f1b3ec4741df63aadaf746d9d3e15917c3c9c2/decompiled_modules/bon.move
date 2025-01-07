module 0x37853ce9f5e7e0ba8ffa60c5f5f1b3ec4741df63aadaf746d9d3e15917c3c9c2::bon {
    struct BON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BON>(arg0, 9, b"BON", b"Ersh", b"Auuaah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1bdaecce-7a15-4d41-b17b-741969349996.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BON>>(v1);
    }

    // decompiled from Move bytecode v6
}

