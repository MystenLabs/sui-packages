module 0xc61578afc8236f58207f790b65cb9f6957c59314a972a0acdebad6fb4ef88472::cana {
    struct CANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANA>(arg0, 6, b"CANA", b"Canna Sapien", b"Canna Sapien > Homo sapien", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953284653.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

