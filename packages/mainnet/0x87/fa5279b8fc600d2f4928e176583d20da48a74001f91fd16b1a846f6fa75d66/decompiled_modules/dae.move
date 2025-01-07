module 0x87fa5279b8fc600d2f4928e176583d20da48a74001f91fd16b1a846f6fa75d66::dae {
    struct DAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAE>(arg0, 9, b"DAE", b"Dasteiy", b"The only way I could do that was ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f227218-fee7-468f-b27a-2e7f6e6d4886.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

