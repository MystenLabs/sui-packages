module 0x95c75dc7efed3c0b82d546f6c668c99ad65ae8dcdb0adfdd4eabe1393f17b3ad::dogos {
    struct DOGOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGOS>(arg0, 6, b"DOGOS", b"Dogo Satoru", b"Dogo Satoru is a special grade jujutsu sorcerer and widely recognized as the strongest in the jujutsu world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dogos_1d857bb516.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

