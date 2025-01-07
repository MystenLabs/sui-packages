module 0x332718d350e26b7f8fe26959705dde5484582f44aa8e7af67865f7de755b6658::brrrt {
    struct BRRRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRRRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRRRT>(arg0, 6, b"BRRRT", b"BRRRT THE A-10", b"WE ARE BRRRT. A MERCENARY GROUP FOR HIRE WITH THE GLORIOUS A-10 WARTHOG AS OUR MASCOT. WE HUNT DOWN ANY AND ALL MEMES AS LONG AS WE ARE PAID UP FRONT. HAVE YOU EVER WANTED TO KILL A MEME AFTER YOU GOT RUGGED OR SCAMMED?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1727552127545_4819a6d9efe52fda5687446f7dc2a6b7_d14cb12ccc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRRRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRRRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

