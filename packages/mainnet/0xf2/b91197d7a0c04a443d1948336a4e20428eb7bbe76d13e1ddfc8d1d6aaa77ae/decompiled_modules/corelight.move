module 0xf2b91197d7a0c04a443d1948336a4e20428eb7bbe76d13e1ddfc8d1d6aaa77ae::corelight {
    struct CORELIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORELIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORELIGHT>(arg0, 9, b"CORELIGHT", b"Battle Blades", b"The Pulse of Luminarch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRUcsFnSa2QwE3HHJbqNevjET61kSwDH8JRvXwuoZKz9X")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CORELIGHT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORELIGHT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORELIGHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

