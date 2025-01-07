module 0x412edb92b8a98d9de08e1bd4247a624c047f86c3000c03f1491f3caff24cb06d::pet {
    struct PET has drop {
        dummy_field: bool,
    }

    fun init(arg0: PET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PET>(arg0, 9, b"PET", b"Pug smile", b"Mypet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/139d4a2e-d82c-4509-bc59-7739e2bc325d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PET>>(v1);
    }

    // decompiled from Move bytecode v6
}

