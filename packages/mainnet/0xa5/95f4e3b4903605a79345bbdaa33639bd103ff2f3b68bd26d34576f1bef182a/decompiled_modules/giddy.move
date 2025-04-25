module 0xa595f4e3b4903605a79345bbdaa33639bd103ff2f3b68bd26d34576f1bef182a::giddy {
    struct GIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIDDY>(arg0, 6, b"GIDDY", b"GiddyOnsui", b"Its time the $GIDDY dev doxxes himself Here is how I made $GIDDY It wouldnt have been possible without this incredible team and community. Thank you all for being part of the journey! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062253_e77541afa9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

