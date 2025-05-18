module 0xcde3e17d18d6012e3259d6667478e13c5b4334c2b723cc041b5d184295658135::san {
    struct SAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAN>(arg0, 9, b"SAN", b"SANDA", b"SANDA is your new meme coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/48a6cb7c80460f086f43c39c92b58b49blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

