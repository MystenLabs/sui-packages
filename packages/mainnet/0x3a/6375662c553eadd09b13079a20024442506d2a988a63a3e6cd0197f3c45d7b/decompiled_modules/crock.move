module 0x3a6375662c553eadd09b13079a20024442506d2a988a63a3e6cd0197f3c45d7b::crock {
    struct CROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CROCK>(arg0, 6, b"CROCK", b"WitcCrock", b"Welcome to WITC CROCK ($CROCK)where meme magic meets the lucky Witch Crock of the sui network born from the iconic and eccentric fusion of genius animals and lucky cards WITC CROCK is more than just a meme token; its a rallying cry for miracle builders, wealth enthusiasts, and crypto rebels.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000058159_3195d3b4e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

