module 0x109cd1c70194b9fb0ad8c6ab8344a4597badd20000fe303efc8724655cc167de::rick {
    struct RICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICK>(arg0, 6, b"RICK", b"SUIRICK", b"Mad Scientist in Sui Network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197670_191aeebe0e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

