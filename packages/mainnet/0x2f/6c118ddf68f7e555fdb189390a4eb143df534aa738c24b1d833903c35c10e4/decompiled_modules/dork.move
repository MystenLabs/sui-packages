module 0x2f6c118ddf68f7e555fdb189390a4eb143df534aa738c24b1d833903c35c10e4::dork {
    struct DORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORK>(arg0, 6, b"DORK", b"DORK LORD SUI", b"Prepare yourself, young Padawan, for the most epic memecoin in the galaxy: Dorklord! Inspired by the hilarious and iconic character created by Matt Furie, Dorklord is here to conquer the SUI blockchain and bring balance to the meme universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3852_c2c4e2b611.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

