module 0x17e6ff54e5fd8a4c1b024701407d9fb5fcb27bb179ebd804bc67c86de0310e3a::mrpres {
    struct MRPRES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRPRES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRPRES>(arg0, 6, b"MRPRES", b"Mr President", b"Ladies and Gentlemen we Present to you the 47th President of The United States of America,  Mr Donald J Trump. To celebrate this occasion we have crafted the best Trump coin on $SUI . $mrpres will be the number one Trump meme on SUI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_27b362ffb0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRPRES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRPRES>>(v1);
    }

    // decompiled from Move bytecode v6
}

