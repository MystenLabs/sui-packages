module 0x258a8d0f88175e9da144673d34ed56fe61591bfd3a8472b8f4b915f20f119ba5::mage {
    struct MAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGE>(arg0, 6, b"MAGE", b"MAGA", b"SEE MAGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732067680945.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

