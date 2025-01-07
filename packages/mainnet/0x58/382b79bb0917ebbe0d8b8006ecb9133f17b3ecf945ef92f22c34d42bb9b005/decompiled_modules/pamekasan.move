module 0x58382b79bb0917ebbe0d8b8006ecb9133f17b3ecf945ef92f22c34d42bb9b005::pamekasan {
    struct PAMEKASAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAMEKASAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAMEKASAN>(arg0, 9, b"PAMEKASAN", b"Banyupelle", b"Salah satu lokasi desa terpencil di madura", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f50a9cba-9d93-497a-9af4-caf8b4bed3e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAMEKASAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAMEKASAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

