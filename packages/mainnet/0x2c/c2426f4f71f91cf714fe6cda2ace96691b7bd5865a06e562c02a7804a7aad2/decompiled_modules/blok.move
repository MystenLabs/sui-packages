module 0x2cc2426f4f71f91cf714fe6cda2ace96691b7bd5865a06e562c02a7804a7aad2::blok {
    struct BLOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOK>(arg0, 6, b"BLOK", b"Blokchayn", b"\"$BLOK Iz here to teachs normiez wat teck iz lfgggggg\" new launch. The blokchayn of prosperity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_c60f60ed08.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

