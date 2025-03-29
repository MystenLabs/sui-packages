module 0xae67adc68b71f8b0d50fe42ae731338dc9613cf4bfb0c409f393e02921a193e4::suimeow {
    struct SUIMEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEOW>(arg0, 9, b"SUIMEOW", b"SUI MEOW MEME", b"Buying this Token will help to feed stray cats.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6437a34878ba3e43b118a607e831244ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEOW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEOW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

