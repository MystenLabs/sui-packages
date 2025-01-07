module 0x3a49c1feb083698157aac4b9c26d73be16e0c7c285f7fdca97cbab6142ee865c::mjr {
    struct MJR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MJR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MJR>(arg0, 9, b"MJR", b"MAJOR", b"major", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a09fa1c-3450-4383-a511-45e4762568fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MJR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MJR>>(v1);
    }

    // decompiled from Move bytecode v6
}

