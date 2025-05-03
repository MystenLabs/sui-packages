module 0xc6c9b4749d896def2c3b798c55835fd282bb38ed36bc80335c087cf606528eb4::roaringkitty {
    struct ROARINGKITTY has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ROARINGKITTY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x171e71f00cc302ae1732a79ca6d2ca686c243c1dd304c4d3279cc6b512050aa, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<ROARINGKITTY>>(0x2::coin::mint<ROARINGKITTY>(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: ROARINGKITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROARINGKITTY>(arg0, 9, b"ROARINGKITTY", b"Roaring Kitty", b"Roaring Kitty on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/jjz9n61h/Roaring-kitty.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROARINGKITTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROARINGKITTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

