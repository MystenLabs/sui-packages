module 0x2417304cbe577bca572445d8cbbd29e83c1ba62fb7105967521a76043be4ed12::slc {
    struct SLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLC>(arg0, 9, b"SLC", b"Sui Legend", b"The legendary Sui captain cat on wave wallet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/096884ed-0a67-44c0-8743-bab2497259ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

