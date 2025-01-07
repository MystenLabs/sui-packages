module 0x46ca523d349f91a460ad601177aaf94cf37e2a4b01807a22cacfd7d86d951528::act {
    struct ACT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACT>(arg0, 9, b"ACT", b"Activeman", b"The token created for the consistent and unrelenting crypto newbies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/48ffd34c-5e1d-4547-b19b-1091db96a76b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACT>>(v1);
    }

    // decompiled from Move bytecode v6
}

