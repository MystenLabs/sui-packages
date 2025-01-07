module 0x49f197421e98a6243316a621ce5a3c60a8433866720ad8ab77f983f82e86a938::shre {
    struct SHRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRE>(arg0, 9, b"SHRE", b"Shrektasti", b"Shrektastic Voyagers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/098b7f6b-9296-4c47-a525-657f374bf435.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

