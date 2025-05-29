module 0xc0fd7ce7f21ac7bd45b2b5a842d419c4d03142e97c08ed102f123b813d58fc4::tica {
    struct TICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICA>(arg0, 9, b"Tica", b"bitica", b"best I.A. performance in sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1ff4204296a732d47b9cf87a7b6cfbacblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TICA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

