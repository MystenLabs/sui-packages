module 0xcce9f6e52cc55e6d00422cc17ece1c3c2f8873e86e9678b0f7fb20ecb601e888::euphoric {
    struct EUPHORIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EUPHORIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EUPHORIC>(arg0, 6, b"EUPHORIC", b"Euphoric", b"everything is flying but guess what we go higher.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732451264839.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EUPHORIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EUPHORIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

