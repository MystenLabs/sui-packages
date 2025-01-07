module 0xd982eecddbbd379e23955a557f70d67af20fddfd139fc5a7224b50bb86cb0675::magatrump {
    struct MAGATRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGATRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGATRUMP>(arg0, 6, b"MagaTrump", b"Magaa Trump", b"https://t.me/magatrump0i", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016704_05b8c4cebe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGATRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGATRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

