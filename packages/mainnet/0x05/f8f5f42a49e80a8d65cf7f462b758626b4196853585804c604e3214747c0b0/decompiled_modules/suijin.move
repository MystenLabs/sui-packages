module 0x5f8f5f42a49e80a8d65cf7f462b758626b4196853585804c604e3214747c0b0::suijin {
    struct SUIJIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJIN>(arg0, 6, b"SUIJIN", b"Suijin god", b" The water god is the guardian deity of water (sui). ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000027961_9683174855.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

