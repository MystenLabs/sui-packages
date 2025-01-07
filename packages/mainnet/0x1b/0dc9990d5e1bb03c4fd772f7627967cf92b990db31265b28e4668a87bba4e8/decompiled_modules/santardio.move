module 0x1b0dc9990d5e1bb03c4fd772f7627967cf92b990db31265b28e4668a87bba4e8::santardio {
    struct SANTARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTARDIO>(arg0, 6, b"SANTARDIO", b"Santardio", b"Ho Ho Ho santardio is here to deliver crypmas gifts this year !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241204_170021_554_9d857cfed3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

