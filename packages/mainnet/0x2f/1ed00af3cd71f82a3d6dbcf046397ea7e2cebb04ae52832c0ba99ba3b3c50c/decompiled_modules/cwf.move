module 0x2f1ed00af3cd71f82a3d6dbcf046397ea7e2cebb04ae52832c0ba99ba3b3c50c::cwf {
    struct CWF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWF>(arg0, 9, b"CWF", b"Catwifhat", b"catrich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/13103c8e-e885-47f2-8bf9-5bde805929a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CWF>>(v1);
    }

    // decompiled from Move bytecode v6
}

