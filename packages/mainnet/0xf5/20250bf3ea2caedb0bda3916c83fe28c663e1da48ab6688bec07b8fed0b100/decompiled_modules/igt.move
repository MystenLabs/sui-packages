module 0xf520250bf3ea2caedb0bda3916c83fe28c663e1da48ab6688bec07b8fed0b100::igt {
    struct IGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGT>(arg0, 6, b"Igt", b"Igniter", b"Best of its kind", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1754934313680.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IGT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

