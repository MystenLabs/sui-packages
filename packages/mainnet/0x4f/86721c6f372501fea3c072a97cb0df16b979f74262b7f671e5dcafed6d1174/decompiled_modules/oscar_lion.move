module 0x4f86721c6f372501fea3c072a97cb0df16b979f74262b7f671e5dcafed6d1174::oscar_lion {
    struct OSCAR_LION has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSCAR_LION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSCAR_LION>(arg0, 9, b"OSCAR", b"Oscar Lion", b"Oscar Lion A Meme Coin Launch On Cetus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.pinata.cloud/ipfs/bafkreickmv7wlexj37z6vcvvdagadxfcul7odfwfjsyql36slwz4uuveku"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<OSCAR_LION>>(0x2::coin::mint<OSCAR_LION>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OSCAR_LION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSCAR_LION>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

