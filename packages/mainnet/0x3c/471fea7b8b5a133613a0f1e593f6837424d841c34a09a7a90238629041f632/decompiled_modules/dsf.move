module 0x3c471fea7b8b5a133613a0f1e593f6837424d841c34a09a7a90238629041f632::dsf {
    struct DSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSF>(arg0, 9, b"DSF", b"GH", b"VCX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ee75ae17-c30d-4349-99cb-d308e463a79f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DSF>>(v1);
    }

    // decompiled from Move bytecode v6
}

