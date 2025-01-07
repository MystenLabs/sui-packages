module 0xa032298c06c46c7bd67e35f52ce5814a13a8ca484ec943ffd7fe10a56b84be0c::sf {
    struct SF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SF>(arg0, 9, b"SF", b"StarFish", b"funny", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkvgiqQ5yvC8V23t9SfzvHrWNDTUhyHxivkg&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SF>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SF>>(v1);
    }

    // decompiled from Move bytecode v6
}

