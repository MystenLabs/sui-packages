module 0x3cc7f7a8b40c48e7d3594789c6014d2b3ac9a663e70c3a1aa78eaf76fa99709e::mcats {
    struct MCATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCATS>(arg0, 6, b"MCATS", b"MILADY CATS", x"43415453204d494c41445920697320610a67656e65726174697665206d656d65636f696e0a696e20616e206165737468657469630a696e737069726564206279204d696c6164790a4d616b65722773207374796c6520747269626573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/886fff28def8793fb26663989de6a599_624cc5a3df.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

