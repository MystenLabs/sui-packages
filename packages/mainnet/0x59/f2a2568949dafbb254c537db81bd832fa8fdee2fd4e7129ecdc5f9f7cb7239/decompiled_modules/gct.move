module 0x59f2a2568949dafbb254c537db81bd832fa8fdee2fd4e7129ecdc5f9f7cb7239::gct {
    struct GCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCT>(arg0, 9, b"GCT", b"GOCAT", x"506c617966756c20616e6420636861726d696e670a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b87924f-05aa-4c50-848d-c939d437b779.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

