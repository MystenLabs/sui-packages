module 0x24b07d7fbb421b008e4d60418cc4e126f6110815fc42b98abc7e10b69ffb7fd3::pola {
    struct POLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLA>(arg0, 6, b"POLA", b"Polabear", b"Hi I'm Pola. I'm the coldest, chilliest, and funniest bear in the entire Arctic. Welcome to my world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731007609012.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

