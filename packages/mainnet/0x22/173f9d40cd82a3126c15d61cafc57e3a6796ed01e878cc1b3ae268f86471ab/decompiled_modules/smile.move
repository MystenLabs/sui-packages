module 0x22173f9d40cd82a3126c15d61cafc57e3a6796ed01e878cc1b3ae268f86471ab::smile {
    struct SMILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMILE>(arg0, 9, b"SMILE", b"Smile cat", b"Smilecat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7663d74d-bb50-47b4-b637-4384c304684f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMILE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMILE>>(v1);
    }

    // decompiled from Move bytecode v6
}

