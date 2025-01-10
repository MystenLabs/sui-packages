module 0x55b3ec037d32e57eb4f34e9ecd4ec6123d2090b75cc537714196eb34fb862ab9::poodle {
    struct POODLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POODLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POODLE>(arg0, 6, b"POODLE", b"Goggles On Poodle", b"Gear up! It's time to make a splash with us onchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/poodle3_619295d9df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POODLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POODLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

