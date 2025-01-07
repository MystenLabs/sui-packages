module 0x2f129d4e233d75f1cc0a5df60fe2c5cb19535853d2caae7890c7296d22e48ba9::trumpfly {
    struct TRUMPFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPFLY>(arg0, 6, b"TrumpFly", b"Trump Fly", b"Trump is flying and we will fly with him to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046575_6a713b49a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPFLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPFLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

