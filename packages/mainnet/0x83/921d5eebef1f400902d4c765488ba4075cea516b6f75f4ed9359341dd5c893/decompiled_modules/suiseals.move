module 0x83921d5eebef1f400902d4c765488ba4075cea516b6f75f4ed9359341dd5c893::suiseals {
    struct SUISEALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEALS>(arg0, 6, b"SUISEALS", b"Sui Seals", b"The memecoin designed for you to HODL and still sleep like a baby.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_3_copy_d60741e1c4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEALS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISEALS>>(v1);
    }

    // decompiled from Move bytecode v6
}

