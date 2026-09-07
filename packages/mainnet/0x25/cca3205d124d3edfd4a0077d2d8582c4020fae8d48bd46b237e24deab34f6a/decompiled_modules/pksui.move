module 0x25cca3205d124d3edfd4a0077d2d8582c4020fae8d48bd46b237e24deab34f6a::pksui {
    struct PKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKSUI>(arg0, 6, b"PKSUI", b"Binderoo Sui Pilot", x"42696e6465726f6f205375692050696c6f7420e280942042696e6465726f6f2062696e64657220746f6b656e", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

