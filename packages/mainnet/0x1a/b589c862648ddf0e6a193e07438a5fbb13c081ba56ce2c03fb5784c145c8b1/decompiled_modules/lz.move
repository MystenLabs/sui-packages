module 0x1ab589c862648ddf0e6a193e07438a5fbb13c081ba56ce2c03fb5784c145c8b1::lz {
    struct LZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: LZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LZ>(arg0, 9, b"LZ", b"Lizz", b"agent who help you to find the best nails design to match with your clothes ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/227eb2bc0cf970799c99fd250182163dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

