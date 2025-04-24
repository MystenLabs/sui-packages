module 0xcb15f2a053a71c43ebd3993fa63a3e3814c2afe20cf62438cb44ed5d77ac9e3c::trencher {
    struct TRENCHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENCHER>(arg0, 9, b"TRENCHER", b"trencher", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdBP8iv4jVkTDk1JgomNMNJefAAFzDvpqTnk7AWN8ah1Y")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRENCHER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRENCHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCHER>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

