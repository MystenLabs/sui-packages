module 0xb88aa5fd34c0fa6840d871957538b31f59866b48b847367c336386c62021e472::auc {
    struct AUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUC>(arg0, 9, b"AUC", b"AUconn.", b"AUconn. is a meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0734a1fd-71b4-4497-9fbd-6405fd03708f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AUC>>(v1);
    }

    // decompiled from Move bytecode v6
}

