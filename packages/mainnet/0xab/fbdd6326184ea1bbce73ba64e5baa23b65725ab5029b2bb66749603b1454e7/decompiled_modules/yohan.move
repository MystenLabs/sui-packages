module 0xabfbdd6326184ea1bbce73ba64e5baa23b65725ab5029b2bb66749603b1454e7::yohan {
    struct YOHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOHAN>(arg0, 6, b"Yohan", b"Johan", b"Born from the mind of the Monster  $JOHAN is the ultimate psychological meme coin. Cold, calculated, and dangerously charismatic, this token channels the chaos and genius of animes most iconic villain, Johan Liebert. No roadmap. No mercy. Just pure manipulation on the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiet5y626ojzc2zcr6ox6rlmpb6363vn6jy4dfi7ulz7msresrvcbu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YOHAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

