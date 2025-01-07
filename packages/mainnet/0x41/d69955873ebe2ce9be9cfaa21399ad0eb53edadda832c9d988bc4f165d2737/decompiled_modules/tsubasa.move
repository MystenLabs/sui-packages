module 0x41d69955873ebe2ce9be9cfaa21399ad0eb53edadda832c9d988bc4f165d2737::tsubasa {
    struct TSUBASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUBASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUBASA>(arg0, 9, b"TSUBASA", b"Tsubasa", x"43e1baa775207468e1bba72054737562617361", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6bcea0c6-43a8-4fd6-b26c-a5a294fdb065.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUBASA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSUBASA>>(v1);
    }

    // decompiled from Move bytecode v6
}

