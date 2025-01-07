module 0x981ac43a38ad3805916a47af21e996dabc542127a1b1d9536c3e1ea475c58e06::fasdaa {
    struct FASDAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FASDAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FASDAA>(arg0, 9, b"FASDAA", b"SDGFSDF", b"DSGDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df7c865a-eaa5-482c-84cd-ba907028665d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FASDAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FASDAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

