module 0x5530506d11c7c5c094fdfd89ceffb2d805cfecacdbfcc67b26b4d9d1b3924233::chipi {
    struct CHIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIPI>(arg0, 6, b"CHIPI", b"chipi", b"Rise and shine its cat season and its time to bounce", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020505_971f867425.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

