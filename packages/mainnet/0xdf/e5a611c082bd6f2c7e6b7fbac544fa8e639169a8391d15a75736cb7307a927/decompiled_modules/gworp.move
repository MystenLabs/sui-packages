module 0xdfe5a611c082bd6f2c7e6b7fbac544fa8e639169a8391d15a75736cb7307a927::gworp {
    struct GWORP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWORP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWORP>(arg0, 6, b"GWORP", b"GWORPONSUI", b"Gworp: intergalactic Adventure Begins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730955673669.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GWORP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWORP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

