module 0xf32e485c236adac644df3041cdc2c5fb7af09ed98b963b464f0b25364334a959::milka {
    struct MILKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILKA>(arg0, 6, b"MILKA", b"Milka On Sui", b"Hi my name is MILKA it's MILKA on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000500_a73617a7a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

