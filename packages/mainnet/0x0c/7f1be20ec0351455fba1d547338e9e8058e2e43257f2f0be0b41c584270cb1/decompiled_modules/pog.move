module 0xc7f1be20ec0351455fba1d547338e9e8058e2e43257f2f0be0b41c584270cb1::pog {
    struct POG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POG>(arg0, 6, b"POG", b"Classic POGs", b"Salam it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1760950360882.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

