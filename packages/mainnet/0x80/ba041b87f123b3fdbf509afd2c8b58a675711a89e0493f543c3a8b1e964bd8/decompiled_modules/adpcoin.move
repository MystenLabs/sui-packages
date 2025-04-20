module 0x80ba041b87f123b3fdbf509afd2c8b58a675711a89e0493f543c3a8b1e964bd8::adpcoin {
    struct ADPCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADPCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADPCOIN>(arg0, 9, b"ADPCOIN", b"Aridropcoin", b"Meme Cryton Sobre aridrops ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/af31dd3da67397eb2ca06852862c8b0ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADPCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADPCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

