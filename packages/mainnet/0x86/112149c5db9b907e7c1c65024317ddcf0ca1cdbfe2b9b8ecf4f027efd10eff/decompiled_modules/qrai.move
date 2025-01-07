module 0x86112149c5db9b907e7c1c65024317ddcf0ca1cdbfe2b9b8ecf4f027efd10eff::qrai {
    struct QRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: QRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QRAI>(arg0, 6, b"QRAI", b"Qrai", b"Create your own unique QR code within seconds using QRAI tool!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/56734567_b355c8cf9a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QRAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QRAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

