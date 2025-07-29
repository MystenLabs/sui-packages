module 0xbb58f72454704cd4467661939c274e61edb3f0411793a724d99c6f1315dd8b35::nowar25 {
    struct NOWAR25 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOWAR25, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOWAR25>(arg0, 6, b"Nowar25", b"Gaza25 ", b"A world full of pain, full of cruelty even for children... without water. without food.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753789528665.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOWAR25>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOWAR25>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

