module 0x249b4f484de7be7282207d999cbb61e1e1da97496e096e22433c67b9ca481172::RIZZ {
    struct RIZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZ>(arg0, 6, b"RIZZ BOT", b"Rizz", b"Rizz bot the best bot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreifzr26bei4ozbi7bnb7spr7s3laoyh7izptm7xru5dksqinfdtnwy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZ>>(v0, @0x691c5d4f7bd7c39b39907d3ca01b8c2643c87de134766ca4f78be51e0a9fde1b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

