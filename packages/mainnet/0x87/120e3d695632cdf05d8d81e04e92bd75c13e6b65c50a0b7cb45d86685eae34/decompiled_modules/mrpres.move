module 0x87120e3d695632cdf05d8d81e04e92bd75c13e6b65c50a0b7cb45d86685eae34::mrpres {
    struct MRPRES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRPRES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRPRES>(arg0, 6, b"MRPRES", b"Mr President", b"Ladies and Gentlemen we present to you the 47th President of the United States of America Mr Donald J Trump. To celebrate we have created $mrpres Meme coin. We have big big plans just like our beloved President. We will be the biggest Trump meme coin on $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_a58c2d2ef8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRPRES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRPRES>>(v1);
    }

    // decompiled from Move bytecode v6
}

