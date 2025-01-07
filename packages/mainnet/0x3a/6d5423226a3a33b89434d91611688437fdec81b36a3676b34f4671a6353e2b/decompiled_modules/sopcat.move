module 0x3a6d5423226a3a33b89434d91611688437fdec81b36a3676b34f4671a6353e2b::sopcat {
    struct SOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOPCAT>(arg0, 6, b"SOPCAT", b"SOPCAT ON SUI", b"Inspired from the popular meme-cat named \"Popcat\", Sopcat just dropped on  SUI Network!  No longer just a meme,Its here!  The legendary Sopcat has arrived on SUI, and this isnt just any coin dropits the ultimate meme slap. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sopcat_7b80ba2e75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

