module 0xe9546a68842541caba7fd0d55f4d4a92d642d445840acf867c0b7ce063e62e9e::girl5 {
    struct GIRL5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIRL5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIRL5>(arg0, 6, b"Girl5", b"girl", b"The daughter is beautiful The daughter is beautiful", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730894820066.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GIRL5>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIRL5>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

