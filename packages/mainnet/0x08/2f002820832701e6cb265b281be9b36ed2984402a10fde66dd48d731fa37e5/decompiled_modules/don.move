module 0x82f002820832701e6cb265b281be9b36ed2984402a10fde66dd48d731fa37e5::don {
    struct DON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DON>(arg0, 6, b"DON", b"The Nutfather", b"Born under the Great Oak, Vinny quickly rose to power, mastering the art of the \"acorn shuffle\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737085648662.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

