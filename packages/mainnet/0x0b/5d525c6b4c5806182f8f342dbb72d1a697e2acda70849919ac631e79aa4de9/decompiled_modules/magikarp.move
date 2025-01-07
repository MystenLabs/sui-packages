module 0xb5d525c6b4c5806182f8f342dbb72d1a697e2acda70849919ac631e79aa4de9::magikarp {
    struct MAGIKARP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGIKARP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGIKARP>(arg0, 9, b"magikarp", b"Magikarp", b"King Pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/FJEhxmFXsAkLDXY?format=jpg&name=900x900")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAGIKARP>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGIKARP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGIKARP>>(v1);
    }

    // decompiled from Move bytecode v6
}

