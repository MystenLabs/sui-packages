module 0x6c83a3dd41665c5c8f544ec3aa4be73b02a297c60fe60f409de94ad5e4df7cf2::nampervn {
    struct NAMPERVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAMPERVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAMPERVN>(arg0, 9, b"NAMPERVN", b"NamPer", b"NamPerVn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/846462b6-7e31-472d-9122-157a8517c4da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAMPERVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAMPERVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

