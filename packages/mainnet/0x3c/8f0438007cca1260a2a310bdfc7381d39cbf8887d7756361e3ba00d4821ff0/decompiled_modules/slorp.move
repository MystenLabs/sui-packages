module 0x3c8f0438007cca1260a2a310bdfc7381d39cbf8887d7756361e3ba00d4821ff0::slorp {
    struct SLORP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLORP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLORP>(arg0, 6, b"Slorp", b"Slorp Sui Network", b"Slorp ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Slorp_Sui_Network_9d8789e26a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLORP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLORP>>(v1);
    }

    // decompiled from Move bytecode v6
}

