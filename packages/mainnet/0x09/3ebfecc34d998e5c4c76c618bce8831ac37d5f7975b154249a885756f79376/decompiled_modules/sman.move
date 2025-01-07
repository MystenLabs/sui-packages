module 0x93ebfecc34d998e5c4c76c618bce8831ac37d5f7975b154249a885756f79376::sman {
    struct SMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMAN>(arg0, 6, b"Sman", b"SuiperMan", b"Superman  on SUI ensures law and order.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029318_f34d42044e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

