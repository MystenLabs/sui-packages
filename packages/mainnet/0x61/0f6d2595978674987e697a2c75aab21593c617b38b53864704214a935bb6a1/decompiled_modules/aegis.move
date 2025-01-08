module 0x610f6d2595978674987e697a2c75aab21593c617b38b53864704214a935bb6a1::aegis {
    struct AEGIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEGIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEGIS>(arg0, 6, b"AEGIS", b"AI Doge", b"The first dog created by artificial intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736321574445.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AEGIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEGIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

