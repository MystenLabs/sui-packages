module 0x35ee41bfc818fe2f91112297a5d9d63e075e8ae97ecf845740ada74ce9e5b3bd::son {
    struct SON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SON>(arg0, 9, b"SON", b"SON", b"Son of Narity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Son_Heung-min_-_2022_%2852552243725%29_%28cropped%29.jpg/640px-Son_Heung-min_-_2022_%2852552243725%29_%28cropped%29.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SON>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SON>>(v1);
    }

    // decompiled from Move bytecode v6
}

