module 0x42e12998f867a45f7be803e4adbb4dc37c4f55dcb3fe5be99362062dbfeafb97::suicker {
    struct SUICKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICKER>(arg0, 6, b"SUICKER", b"SUICKERBERG", b"Everyone knows about the relationship between meta/facebook and the SUI blockchain. Let's use this trigger to send this. https://suickerberg.fun/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suick_79da4842bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICKER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

