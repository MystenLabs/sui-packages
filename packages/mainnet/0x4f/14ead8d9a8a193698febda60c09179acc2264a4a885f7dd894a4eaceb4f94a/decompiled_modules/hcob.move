module 0x4f14ead8d9a8a193698febda60c09179acc2264a4a885f7dd894a4eaceb4f94a::hcob {
    struct HCOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCOB>(arg0, 9, b"HCOB", b"Head Cobra", b"The Head cobra meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/afa572aa-256f-4781-b392-751cdab22d18.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HCOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

