module 0x835a5847685d02d1c41610594090944dcf911d5cebca21746a67b8817320e26::auc {
    struct AUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUC>(arg0, 9, b"AUC", b"AUconn.", b"AUconn. is a meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b644e995-d892-4ef6-9790-a7039d0bbb7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

