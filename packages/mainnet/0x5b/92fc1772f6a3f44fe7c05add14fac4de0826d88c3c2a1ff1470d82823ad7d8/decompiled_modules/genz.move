module 0x5b92fc1772f6a3f44fe7c05add14fac4de0826d88c3c2a1ff1470d82823ad7d8::genz {
    struct GENZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENZ>(arg0, 9, b"GENZ", b"GENZ", b"Dude stay here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.mds.yandex.net/i?id=7ea9110206afab20bda3f1a6af719d1d-4238102-images-thumbs&n=13")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GENZ>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

