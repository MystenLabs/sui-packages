module 0x37f2b7e09a54984d667fa5e8715d688aae4df0ae0fc8d839fe908f061835e9f2::dsf {
    struct DSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSF>(arg0, 9, b"DSF", b"H", b"BFV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e53cac01-ff14-4669-9892-8f1a1e2567ae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSF>>(v1);
    }

    // decompiled from Move bytecode v6
}

