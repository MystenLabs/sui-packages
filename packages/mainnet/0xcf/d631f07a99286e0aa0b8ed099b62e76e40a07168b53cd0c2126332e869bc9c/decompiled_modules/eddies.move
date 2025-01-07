module 0xcfd631f07a99286e0aa0b8ed099b62e76e40a07168b53cd0c2126332e869bc9c::eddies {
    struct EDDIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDDIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDDIES>(arg0, 6, b"EDDIES", b"Eurodollars 2077", b"Token inspired by the Cyberpunk 2077 video game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eddies_4cdff141ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDDIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDDIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

