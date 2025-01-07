module 0xd62ff0e1c2048ef38368a2d00bf2a92e75b5682e4bb0db8ab579b49cd114d75d::wewe {
    struct WEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWE>(arg0, 6, b"WEWE", b"WEWE", b"Meme coin created by the WavePump community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://plum-accurate-ermine-64.mypinata.cloud/ipfs/QmWuVYjrVzJwcsY9HCytqP3enra8q62VriKN1xbM3Kvg3H")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WEWE>>(0x2::coin::mint<WEWE>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WEWE>>(v2);
    }

    // decompiled from Move bytecode v6
}

