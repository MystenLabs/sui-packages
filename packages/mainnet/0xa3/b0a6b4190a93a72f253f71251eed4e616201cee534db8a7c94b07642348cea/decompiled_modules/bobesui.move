module 0xa3b0a6b4190a93a72f253f71251eed4e616201cee534db8a7c94b07642348cea::bobesui {
    struct BOBESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBESUI>(arg0, 6, b"Bobesui", b"BOBE SUI", b"BOBE on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_01_09_35_508769d757.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

