module 0x8b11528e958474472cb38e44b0d94bbb4214f26191fc99b26b0e17909cd6e36::huehue {
    struct HUEHUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUEHUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUEHUE>(arg0, 9, b"HueHue", b"Ugandan Knuckles", b"Dis is the way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5b6e2dbef591d5728840fb9939ce87f1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUEHUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUEHUE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

