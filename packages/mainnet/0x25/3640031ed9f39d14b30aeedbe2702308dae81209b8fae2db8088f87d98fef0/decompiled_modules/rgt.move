module 0x253640031ed9f39d14b30aeedbe2702308dae81209b8fae2db8088f87d98fef0::rgt {
    struct RGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RGT>(arg0, 9, b"RGT", b"Regent", b"Be Brave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50b98f5c-5200-44c1-92f9-880ba9cfd4a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RGT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RGT>>(v1);
    }

    // decompiled from Move bytecode v6
}

