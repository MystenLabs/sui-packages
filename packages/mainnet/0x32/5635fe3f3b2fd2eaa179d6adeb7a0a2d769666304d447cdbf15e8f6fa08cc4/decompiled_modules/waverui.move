module 0x325635fe3f3b2fd2eaa179d6adeb7a0a2d769666304d447cdbf15e8f6fa08cc4::waverui {
    struct WAVERUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVERUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVERUI>(arg0, 9, b"WAVERUI", b"$Rui", b"waverui, a potential trading platform, has started its work in the direction of developing money in your pocket", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb275761-b60c-419f-8ebf-66ab44bba729-1000068191.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVERUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVERUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

