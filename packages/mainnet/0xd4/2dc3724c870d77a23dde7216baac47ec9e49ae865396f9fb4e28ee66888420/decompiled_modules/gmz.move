module 0xd42dc3724c870d77a23dde7216baac47ec9e49ae865396f9fb4e28ee66888420::gmz {
    struct GMZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMZ>(arg0, 6, b"Gmz", b"Green Mountain Zoo", b"The House of Moo deng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020564_e8f0b494ec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

