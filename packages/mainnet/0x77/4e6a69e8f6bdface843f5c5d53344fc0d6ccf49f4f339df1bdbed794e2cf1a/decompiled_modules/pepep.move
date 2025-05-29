module 0x774e6a69e8f6bdface843f5c5d53344fc0d6ccf49f4f339df1bdbed794e2cf1a::pepep {
    struct PEPEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEP>(arg0, 9, b"Pepep", b"pepepe", b"meme baseado na meme da solana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/96fe35019debf5b2ebcb2a0b913086a8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

