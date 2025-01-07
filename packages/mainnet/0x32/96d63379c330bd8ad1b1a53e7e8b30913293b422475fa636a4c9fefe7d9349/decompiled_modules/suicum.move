module 0x3296d63379c330bd8ad1b1a53e7e8b30913293b422475fa636a4c9fefe7d9349::suicum {
    struct SUICUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICUM>(arg0, 6, b"SUICUM", b"PROJECT SUICUM", b"Token that fills up the Sui Network \"jar\" with each new buyer. Every holder is part of the collective, adding to the jar's strength as we build this unique, boundary-pushing community together. Embrace the sexy side of crypto with $SUICUM, where every drop counts!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ahh3_9b2b71cddd.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

