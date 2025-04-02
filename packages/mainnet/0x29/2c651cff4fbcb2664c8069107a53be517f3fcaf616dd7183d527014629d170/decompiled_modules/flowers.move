module 0x292c651cff4fbcb2664c8069107a53be517f3fcaf616dd7183d527014629d170::flowers {
    struct FLOWERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOWERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOWERS>(arg0, 9, b"Flowers", b"FWS", b"Sui Flowers Sui Flowers Sui Flowers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f68695b859d5d9024ceb8f810126e4e4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOWERS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOWERS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

