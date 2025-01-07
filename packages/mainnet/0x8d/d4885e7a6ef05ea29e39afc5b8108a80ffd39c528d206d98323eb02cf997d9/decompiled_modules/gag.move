module 0x8dd4885e7a6ef05ea29e39afc5b8108a80ffd39c528d206d98323eb02cf997d9::gag {
    struct GAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAG>(arg0, 6, b"GAG", b"BallGag", b"Memetoken based on SUI Blockchain. Our mission is grow and build together on SUI, lets get moving to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731206638054.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

