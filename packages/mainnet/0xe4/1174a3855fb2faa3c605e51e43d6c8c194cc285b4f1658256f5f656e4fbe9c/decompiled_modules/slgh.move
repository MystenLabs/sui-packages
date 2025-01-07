module 0xe41174a3855fb2faa3c605e51e43d6c8c194cc285b4f1658256f5f656e4fbe9c::slgh {
    struct SLGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLGH>(arg0, 6, b"SLGH", b"SulaLaughs", b"$SLGH is here to make waves in the memecoin universe ! Built on the lightning-fast sui network, this token combines humor and real value like never", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003002_be7d76c908.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

