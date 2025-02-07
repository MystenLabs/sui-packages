module 0x90519c5abfd1dac59d2c95c19d7c7acd7ed629133ae43e678114768dddbc4b7d::chump {
    struct CHUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUMP>(arg0, 6, b"CHUMP", b"Chill Trump", x"4368696c6c205472756d70206973206865726520746f2072656d696e6420796f7520746f2074616b65206120646565702062726561746820616e6420646f206e6f742067697665206120662a636b2c206368696c6c20f09f9286f09f8fbbe2808de29982efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738957616927.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

