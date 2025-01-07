module 0xce3384e72fb452ff7288ee21a1863d39b62769d25af0ded69d0fce91f32abb15::md {
    struct MD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MD>(arg0, 9, b"MD", b"Mother Dog", b"mother of Doge Coin, a child must love his mother. support the mother dog so she can be with her child.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/969ff706-d7f8-4b8e-852f-7059f30608bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MD>>(v1);
    }

    // decompiled from Move bytecode v6
}

