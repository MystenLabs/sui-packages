module 0x21bf8744c89f0104228714d0ddc8a2631acc1e98286e61ba00fd41141c0444f0::aplm {
    struct APLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: APLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APLM>(arg0, 9, b"APLM", b"Apolomax", b"New token distribution ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ab51fb3-5f92-4abf-90d6-f7de122f80aa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

