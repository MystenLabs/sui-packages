module 0x7169f35fdaeba0dbccda0f8a61f8f67cd4af36441a281fd13ea63fc167130342::kimchi {
    struct KIMCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMCHI>(arg0, 6, b"KIMCHI", b"KIMCHI SUI", b"Kimchi simply aims to bring a little spice to the Sui Chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kimchi_29b09685f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIMCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIMCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

