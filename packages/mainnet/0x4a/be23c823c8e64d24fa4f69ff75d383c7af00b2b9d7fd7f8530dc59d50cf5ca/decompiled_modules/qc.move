module 0x4abe23c823c8e64d24fa4f69ff75d383c7af00b2b9d7fd7f8530dc59d50cf5ca::qc {
    struct QC has drop {
        dummy_field: bool,
    }

    fun init(arg0: QC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QC>(arg0, 6, b"QC", b"teamQC", b"tests", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1764148393808.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

