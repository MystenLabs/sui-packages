module 0x5b852e2405d2e8a2b1440b4f62b279e70699673c9be4f3417ccdea6716f5593c::bachira {
    struct BACHIRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACHIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACHIRA>(arg0, 9, b"BACHIRA", b"Meguru Bachira", b"Bachira has a rather eccentric demeanor and personality. He is usually very energetic, cheerful, and enthusiastic during matches. Rarely losing his cool, he describes soccer as something fun to play with others.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/qdFrzOA.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BACHIRA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACHIRA>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BACHIRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

