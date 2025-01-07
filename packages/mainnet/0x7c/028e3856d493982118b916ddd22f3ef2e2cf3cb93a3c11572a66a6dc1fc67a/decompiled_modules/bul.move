module 0x7c028e3856d493982118b916ddd22f3ef2e2cf3cb93a3c11572a66a6dc1fc67a::bul {
    struct BUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUL>(arg0, 9, b"BUL", b"bul", b"...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1775666269041082368/LfEsIJAv_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUL>(&mut v2, 12000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

