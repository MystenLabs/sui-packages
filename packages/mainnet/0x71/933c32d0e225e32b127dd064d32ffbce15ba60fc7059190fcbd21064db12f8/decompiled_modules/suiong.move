module 0x71933c32d0e225e32b127dd064d32ffbce15ba60fc7059190fcbd21064db12f8::suiong {
    struct SUIONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIONG>(arg0, 6, b"SUIONG", b"SUIONG", b"From 0 to 10 million!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media1.tenor.com/m/QHWND4RQG1AAAAAC/cat-cat-memes.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIONG>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIONG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

