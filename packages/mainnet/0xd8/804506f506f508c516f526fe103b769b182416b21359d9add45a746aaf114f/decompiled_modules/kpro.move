module 0xd8804506f506f508c516f526fe103b769b182416b21359d9add45a746aaf114f::kpro {
    struct KPRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KPRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KPRO>(arg0, 6, b"KPRO", b"KLASSPRO", b"Decentralize Learning Management System", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1742670864587.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KPRO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KPRO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

