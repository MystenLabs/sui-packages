module 0x6c7dbdb5669af09739df0b798a5986c7dd62ffd64ee25a910222d0f98b4b7f96::pongo {
    struct PONGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONGO>(arg0, 6, b"PONGO", b"Pongo Coin", b"Welcome to the one and only $pongo!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021976_93419dea1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

