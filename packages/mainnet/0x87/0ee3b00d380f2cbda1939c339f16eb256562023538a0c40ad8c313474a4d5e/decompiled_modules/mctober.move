module 0x870ee3b00d380f2cbda1939c339f16eb256562023538a0c40ad8c313474a4d5e::mctober {
    struct MCTOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCTOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCTOBER>(arg0, 6, b"MCTOBER", b"Mctober Sui", b"WW3 , crypto down back to grind at mcdonalds this October.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_4896fb63e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCTOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCTOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

