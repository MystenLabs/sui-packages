module 0x9ffb6e63512c2ae17a588b1eaeb30efbd1a898fe2d1336ae9507119acf0fdadb::siu {
    struct SIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIU>(arg0, 6, b"SIU", b"SIU CR7", b"Inspired by the iconic Cristiano Ronaldo celebration, The SIUUU Token is a fun and community-driven meme coin on the SUI blockchain. Join the SIUUU Army and be part of a growing community that celebrates the joy of football and the thrill of crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/siuuuu_e6c56823d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

