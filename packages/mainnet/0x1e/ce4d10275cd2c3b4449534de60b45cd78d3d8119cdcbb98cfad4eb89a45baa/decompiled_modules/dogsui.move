module 0x1ece4d10275cd2c3b4449534de60b45cd78d3d8119cdcbb98cfad4eb89a45baa::dogsui {
    struct DOGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSUI>(arg0, 6, b"DOGSUI", b"DOGS ON SUI", b"$DOGE led the meme revolution for over a decade, now it's $DOGSUI turn to reign supreme. Embrace the rise of $DOGSUI, poised to become the largest and most vibrant community on the SUI blockchain. Join us, as we make history with humor, one meme at a time!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dogssui_302a8e3146.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

