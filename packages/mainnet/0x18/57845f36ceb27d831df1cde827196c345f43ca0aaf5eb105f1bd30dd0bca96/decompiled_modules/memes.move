module 0x1857845f36ceb27d831df1cde827196c345f43ca0aaf5eb105f1bd30dd0bca96::memes {
    struct MEMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMES>(arg0, 6, b"MEMES", b"Memes", b"The King Memes On Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003522_a176f83426.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

