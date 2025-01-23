module 0x2fd0b55c27ed77c95820cc23a86fa1950b3693450ec83893527d037c8ec44768::vine {
    struct VINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINE>(arg0, 6, b"Vine", b"Vine Coin", b"$Vine on $SUI. Don't miss it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737629954638.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VINE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

