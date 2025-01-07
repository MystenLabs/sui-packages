module 0x9d2ee862fc78ff3fa34f1e244da43b95b842f27ddf081c8d31acb9c7dc555f25::ngl {
    struct NGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGL>(arg0, 6, b"NGL", b"tsl", b"Nikola Tesla was a genius inventor who created some groundbreaking inventions. Tesla also collaborated with many big names and companies in history", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u_1389859128_1365665791_and_fm_253_and_fmt_auto_and_app_138_and_f_JPEG_4b87ce8204.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NGL>>(v1);
    }

    // decompiled from Move bytecode v6
}

