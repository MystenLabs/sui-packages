module 0x145ac7e11996225a60d786e248a87bef62a0f11c4d76ef2fb91751eb427fb98c::stress {
    struct STRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRESS>(arg0, 9, b"STRESS", b"ST", b"Stress when work", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/476ac46b-dc61-4491-a810-851692b674a8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

