module 0x9b74cfe01ed741ab5a4a1cd2bbfc29df1b1b16de97781f45f376922aa39a512b::bluedork {
    struct BLUEDORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEDORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEDORK>(arg0, 6, b"BLUEDORK", b"BLUEDORKLORD", b"Prepare yourself, young Padawan, for the most epic memecoin in the galaxy: Dorklord! Inspired by the hilarious and iconic character created by Matt Furie, Dorklord is here to conquer the SUI blockchain and bring balance to the meme universe. Forget the Si", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3852_fdd8e27b58.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEDORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

