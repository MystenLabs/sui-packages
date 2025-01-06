module 0xd929944cc967b819518d911e4f5634c72d5f6068650806becea1fe0dd69c38e5::suidonkey {
    struct SUIDONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDONKEY>(arg0, 6, b"SuiDonkey", b"Ai Ai", b"a donkey, also a god", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736195115511.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDONKEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDONKEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

