module 0x8e5dc50fa14ff8cc10ae9e1746b79b7b81870b32cee047efb4f2053fd7d48261::lih {
    struct LIH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIH>(arg0, 9, b"LIH", b"LEOISHERE", b"LEO IS HERE IS A MEME COIN FOR LEO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8d3650a6766280e65fe5e0671314475eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

