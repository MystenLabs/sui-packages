module 0x64f474883b1655fb4b3969bb7a9013c4265bb185a6857ca725291b806048ef5c::crs {
    struct CRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRS>(arg0, 9, b"CRS", b"Criuse", b"Catch criuse for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ffb436ab-eec8-4787-b0a4-4e6469959edb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

