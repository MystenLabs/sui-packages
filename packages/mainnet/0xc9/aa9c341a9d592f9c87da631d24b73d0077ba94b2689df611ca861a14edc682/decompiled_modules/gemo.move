module 0xc9aa9c341a9d592f9c87da631d24b73d0077ba94b2689df611ca861a14edc682::gemo {
    struct GEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEMO>(arg0, 9, b"GEMO", b"GEMO", b"First Sui RWA focused meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1851361237218533376/m9gCn9Up_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GEMO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEMO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

