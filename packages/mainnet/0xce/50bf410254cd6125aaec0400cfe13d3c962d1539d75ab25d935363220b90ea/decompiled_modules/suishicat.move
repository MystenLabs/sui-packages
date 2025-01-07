module 0xce50bf410254cd6125aaec0400cfe13d3c962d1539d75ab25d935363220b90ea::suishicat {
    struct SUISHICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHICAT>(arg0, 6, b"Suishicat", b"suishicat_sui", b"Suishi with a twist of purrfection, combining the cuteness of cats and the art of sushi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suishicat_22a4ef2edb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

