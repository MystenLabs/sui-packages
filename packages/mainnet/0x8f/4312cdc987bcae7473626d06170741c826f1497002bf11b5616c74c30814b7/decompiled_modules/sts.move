module 0x8f4312cdc987bcae7473626d06170741c826f1497002bf11b5616c74c30814b7::sts {
    struct STS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STS>(arg0, 6, b"STS", b"seal to sui", b"Just an adorable lil seal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240918113935_f5789b8ae0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STS>>(v1);
    }

    // decompiled from Move bytecode v6
}

