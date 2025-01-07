module 0x47149aae6bb2f39487cf39c4e9adda9e750b7769efe33bbd109bcc58028feb23::zevus {
    struct ZEVUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEVUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEVUS>(arg0, 9, b"ZEVUS", b"Zevs", b"Zevs cats ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5a109ac-2afb-412f-8fb5-2400601bb57c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEVUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEVUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

