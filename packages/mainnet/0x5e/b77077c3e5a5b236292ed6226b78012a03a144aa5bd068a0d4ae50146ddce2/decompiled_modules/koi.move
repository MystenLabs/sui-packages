module 0x5eb77077c3e5a5b236292ed6226b78012a03a144aa5bd068a0d4ae50146ddce2::koi {
    struct KOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOI>(arg0, 6, b"KOI", b"KoiOnSui", x"4120426f6c642046697368204d616b696e67205761766573206f66205765616c746820696e2074686520537569204f6365616e200a405375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rimf_TUIK_400x400_9a8817ae78.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

