module 0x373cb383089493987cbf03545a524d92931a2d0f654af17594caa5145a5982e9::auc {
    struct AUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUC>(arg0, 9, b"AUC", b"AUconn.", b"AUconnection is a meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e7bf8a1-05d3-42b8-a7ca-0418c71461b1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

