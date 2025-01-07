module 0x1ba92722b9f206cf21a2971a6ffa3d73f717de71c437919dd2c8e11975596a27::fatty {
    struct FATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATTY>(arg0, 6, b"FATTY", b"Fattysui", b"Memecoin Have Fun with Fatty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732366758117.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FATTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

