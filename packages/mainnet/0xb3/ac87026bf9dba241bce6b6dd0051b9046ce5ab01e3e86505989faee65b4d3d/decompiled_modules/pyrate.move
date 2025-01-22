module 0xb3ac87026bf9dba241bce6b6dd0051b9046ce5ab01e3e86505989faee65b4d3d::pyrate {
    struct PYRATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYRATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYRATE>(arg0, 6, b"PYRATE", b"PYRATE GANG", b"as a project our main objective is to create path of least resistance for everyone in the crypto space and overtake the corrupt centralized banking system.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737549898732.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PYRATE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYRATE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

