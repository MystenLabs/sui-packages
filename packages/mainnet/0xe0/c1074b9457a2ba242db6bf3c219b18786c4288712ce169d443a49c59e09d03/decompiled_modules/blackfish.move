module 0xe0c1074b9457a2ba242db6bf3c219b18786c4288712ce169d443a49c59e09d03::blackfish {
    struct BLACKFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKFISH>(arg0, 6, b"BLACKFISH", b"$BLACKFISH ON SUI", b"Inspired by the strength and legacy of killer whales, $BLACKFISH on the SUI  is more than a token its a movement for change. Honoring the memory of Orca.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241118_132705_796_e1838444cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

