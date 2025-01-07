module 0xc37fea7d7f9dac03d1dbd33bb5bdb5a1aabf4e87c7a6c9f23ce57a7fcc474dab::twrae {
    struct TWRAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWRAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWRAE>(arg0, 9, b"TWRAE", b"Trump Was Right About Everything", b"Trump was right you are ghetting rich in 2025 enjoy !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c139d7fec2c254413e49edfc9419b15cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWRAE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWRAE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

