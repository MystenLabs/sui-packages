module 0x978400509555f9f72a6ea2ce2320392fad2958daba4500b1b0a19f9741383285::zzbt {
    struct ZZBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZBT>(arg0, 9, b"ZZBT", b"battri", b"battrizz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dae5b16b-8e1a-4423-b9f4-0e58926efb4c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZZBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

