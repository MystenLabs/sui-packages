module 0xa5762b38b400e67e6d64ad6e4486ce7cfb15671f871ab1cc37cc7e9fd40a144d::nsaiv2 {
    struct NSAIV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSAIV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSAIV2>(arg0, 6, b"NSAIV2", b"NEURAL SUI AI V2.0", b"Neural SUI AI v2.0 is a state-of-the-art artificial intelligence platform designed to revolutionize the way we establish secure and intelligent connections in a fast-paced digital world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736057434325.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSAIV2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSAIV2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

