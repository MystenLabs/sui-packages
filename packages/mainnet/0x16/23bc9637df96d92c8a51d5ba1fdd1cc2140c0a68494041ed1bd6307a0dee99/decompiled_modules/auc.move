module 0x1623bc9637df96d92c8a51d5ba1fdd1cc2140c0a68494041ed1bd6307a0dee99::auc {
    struct AUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUC>(arg0, 9, b"AUC", b"AUconn.", b"AUconn. is a mene coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16b12553-3a89-4cfd-abef-889e63ac9657.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

