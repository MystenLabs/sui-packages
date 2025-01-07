module 0x76a76e578164c85e3116b70b9ec55be769bf6fb783c2a1b4f90cadf37c7dbe87::atido {
    struct ATIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATIDO>(arg0, 9, b"ATIDO", b"Atis", b"Atissss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f79ed093-586c-4e00-85c5-aa7cace25c75.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATIDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

