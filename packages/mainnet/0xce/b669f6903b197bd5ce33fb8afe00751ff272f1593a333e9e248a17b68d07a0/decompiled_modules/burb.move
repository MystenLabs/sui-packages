module 0xceb669f6903b197bd5ce33fb8afe00751ff272f1593a333e9e248a17b68d07a0::burb {
    struct BURB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURB>(arg0, 6, b"BURB", b"Burblos", b"Burb on Turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731007970403.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BURB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

