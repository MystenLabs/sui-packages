module 0xfcd2377734d04e7dd5fe591ba0badb5b88bae621089d780397bf980f59495ea2::denim {
    struct DENIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENIM>(arg0, 6, b"DENIM", b"Sui Denim", b"DENIM MAKE SUI TO GREAT AGAIN! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054560_7c1cd8011f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

