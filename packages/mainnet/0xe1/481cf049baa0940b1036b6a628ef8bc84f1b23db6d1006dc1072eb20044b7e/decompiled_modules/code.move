module 0xe1481cf049baa0940b1036b6a628ef8bc84f1b23db6d1006dc1072eb20044b7e::code {
    struct CODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CODE>(arg0, 6, b"Code", b"Barcode", b"Digital code for money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1760325895918.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CODE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CODE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

