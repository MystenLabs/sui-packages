module 0x8cd469afbd4d0f13100acc276b3aa2a0b61feae9b6551fbda0860bd94b178b77::shikoku {
    struct SHIKOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIKOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIKOKU>(arg0, 6, b"SHIKOKU", b"Mikawa Inu", x"57656c636f6d6520746f205368696b6f6b75210a546865206e65787420626967207468696e6720696e2063727970746f20776f726c64206372656174656420746f20666f6c6c6f77207468652073746570732074616b656e20627920736869626120696e752e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732701071129.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIKOKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIKOKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

