module 0xb026319d8cd26e978c858818a582ac0f246026afde52aa2ae8c4da9d5543cf62::aai {
    struct AAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAI>(arg0, 6, b"AAI", b"Agent AI", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737389691407.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

