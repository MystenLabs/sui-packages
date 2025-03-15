module 0x561ea65e313b68a5ce7bd43a10ff5ee39f1c06a6b592318aa3585b316f89a605::mcx {
    struct MCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCX>(arg0, 9, b"MCX", b"2 - 200 = ?", b"202.68 202.69 202.70 202.71 202. 202.79", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e24fc92bf491a16f4322c0f61c205f05blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

