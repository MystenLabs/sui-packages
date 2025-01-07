module 0x959f148e5398f8ba640f9e83ea02c072cab9760f606c2c002800ae7f174500c4::banana {
    struct BANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANANA>(arg0, 6, b"BANANA", b"Doxxed It ", x"4475636b2074617065642042414e414e41206279204d617572697a696f2043617474656c616e206e6578742077696c6c206d616b6520612077617920746f20746865206175746572737061636520776974682075732021f09f8d8cf09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732277902091.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BANANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

