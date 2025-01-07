module 0x9de904a894417d3ac923ca9391791b586dba819d6836f400b92bbc0b248bcad9::fuddies {
    struct FUDDIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDDIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDDIES>(arg0, 6, b"FUDDIES", b"Fuddies", b"Art based token, a fuddie will be airdroped to top buy on first 10h", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fuddies_eb84d506c9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDDIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUDDIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

