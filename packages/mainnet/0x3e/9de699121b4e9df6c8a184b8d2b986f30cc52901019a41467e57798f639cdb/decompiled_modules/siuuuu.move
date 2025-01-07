module 0x3e9de699121b4e9df6c8a184b8d2b986f30cc52901019a41467e57798f639cdb::siuuuu {
    struct SIUUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUUUU>(arg0, 6, b"SIUUUU", b"SIUUUUU", b"SIUUUUUUU! Just the goat in the goat chain! SIUUUUUUUUUU! ALL NATURALE CR7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731617639492.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIUUUU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUUUU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

