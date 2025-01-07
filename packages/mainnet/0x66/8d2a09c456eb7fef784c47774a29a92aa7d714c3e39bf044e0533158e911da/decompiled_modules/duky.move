module 0x668d2a09c456eb7fef784c47774a29a92aa7d714c3e39bf044e0533158e911da::duky {
    struct DUKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKY>(arg0, 6, b"DUKY", b"Duky", b"Duky is a fun and quirky meme coin on the Sui blockchain, inspired by the playful spirit of a duck. With $DUKY, dive into the world of humor, community-driven vibes, and quacktastic rewards! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731631276616.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

