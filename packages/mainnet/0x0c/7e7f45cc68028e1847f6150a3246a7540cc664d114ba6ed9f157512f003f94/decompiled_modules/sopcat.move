module 0xc7e7f45cc68028e1847f6150a3246a7540cc664d114ba6ed9f157512f003f94::sopcat {
    struct SOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOPCAT>(arg0, 6, b"SOPCAT", b"SOPCATSUI", b"Inspired from the popular meme-cat named \"Popcat\", Sopcat just dropped on  SUI Network!  No longer just a meme,Its here!  The legendary Sopcat has arrived on SUI, and this isnt just any coin dropits the ultimate meme slap. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_29_14_22_21_a0cea3ddf8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

