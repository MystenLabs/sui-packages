module 0xe7deb8b29b4b7743ef64776a185d2e53154fd81b2e122c05f3ae65efc7d57002::lbw {
    struct LBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBW>(arg0, 9, b"Lbw", b"lbwnb", x"6c62776e6261610a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0b1efc06f8c826d21f71b1e9fc63eb24blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

