module 0x5c00f0d19b3e0283a9a4c0a68e14e2eabb98159911d4102769522045631f4944::turbonator {
    struct TURBONATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBONATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBONATOR>(arg0, 6, b"Turbonator", b"The Turbonator", b"The Turbonator is the protector of Turbos. Slaying the sui competition!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953127381.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBONATOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBONATOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

