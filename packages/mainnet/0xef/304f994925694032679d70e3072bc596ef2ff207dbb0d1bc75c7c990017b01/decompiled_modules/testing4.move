module 0xef304f994925694032679d70e3072bc596ef2ff207dbb0d1bc75c7c990017b01::testing4 {
    struct TESTING4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTING4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTING4>(arg0, 6, b"TEsting4", b"Tesgin3", b"Tesq32", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732594622042.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESTING4>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTING4>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

