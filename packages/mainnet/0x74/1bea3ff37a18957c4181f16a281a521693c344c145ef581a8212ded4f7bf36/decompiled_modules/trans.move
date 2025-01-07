module 0x741bea3ff37a18957c4181f16a281a521693c344c145ef581a8212ded4f7bf36::trans {
    struct TRANS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRANS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRANS>(arg0, 6, b"TRANS", b"Delicious", b"We are here in the crypto space representing all things trans and dressing. Come and join us. Nobody has to know x", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/611e94ce6644b34a9b79865af94f2ed0_38770c6900.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRANS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRANS>>(v1);
    }

    // decompiled from Move bytecode v6
}

