module 0x4f5e3c4defdd1b531dc0c7d79e1471fd6cd06b41672b3f84a0cced5f8371781c::act {
    struct ACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACT>(arg0, 9, b"ACT", b"Activeman", b"Token for the active and unrelenting crypto newbies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7c4e8c7-43e7-455f-9171-383c70eee8b4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACT>>(v1);
    }

    // decompiled from Move bytecode v6
}

