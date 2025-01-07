module 0x5543188f0c66835a66722d165d2f022f2e21fda182bddb4fd9841520968b4521::mydog {
    struct MYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYDOG>(arg0, 6, b"Mydog", b"My dog in fukin sui", b"Es morgan tiene 11 anios y a los  5 quedo asi, compren el token asi le puedo compar comidita", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mi_dog_in_fuckin_sui_fd7fa82cb5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

