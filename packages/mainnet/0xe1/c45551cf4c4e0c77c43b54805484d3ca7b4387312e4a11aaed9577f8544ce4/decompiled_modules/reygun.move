module 0xe1c45551cf4c4e0c77c43b54805484d3ca7b4387312e4a11aaed9577f8544ce4::reygun {
    struct REYGUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: REYGUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REYGUN>(arg0, 6, b"REYGUN", b"Reygun", b"Assie Alympic Brek Danser - Rachael Louise Gunn, known comptitavely as Reygun, is an Australian acedamic and comptitive brekdanser. She is a lacturer in the Deportmant of Media, Cammunicatians, Cretive Arts, Lenguage and Leterature at Mecquarie Univerity Facilty of Arts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241201_145027_367_c2f808f683.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REYGUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REYGUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

