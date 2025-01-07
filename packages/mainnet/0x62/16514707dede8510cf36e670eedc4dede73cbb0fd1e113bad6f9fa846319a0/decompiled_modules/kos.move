module 0x6216514707dede8510cf36e670eedc4dede73cbb0fd1e113bad6f9fa846319a0::kos {
    struct KOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOS>(arg0, 6, b"KOS", b"KoiOnSui", x"4120426f6c642046697368204d616b696e67205761766573206f66205765616c746820696e2074686520537569204f6365616e200a405375694e6574776f726b0a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/koin_soi_367055a341.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

