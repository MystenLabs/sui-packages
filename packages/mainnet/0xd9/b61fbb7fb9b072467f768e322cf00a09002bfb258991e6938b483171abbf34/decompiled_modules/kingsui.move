module 0xd9b61fbb7fb9b072467f768e322cf00a09002bfb258991e6938b483171abbf34::kingsui {
    struct KINGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGSUI>(arg0, 6, b"KINGSUI", b"KING KONG SUI", b"kingkong just memecoin on sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730966108652.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KINGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

