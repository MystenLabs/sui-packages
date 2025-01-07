module 0xa7d2fc6fee2a3246e2216251579798f2eceba6a686a3c09266381a42ae226cbd::sqm {
    struct SQM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQM>(arg0, 6, b"Sqm", b"squilomox", b"o esquilo q venho para ficar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732285693013.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

