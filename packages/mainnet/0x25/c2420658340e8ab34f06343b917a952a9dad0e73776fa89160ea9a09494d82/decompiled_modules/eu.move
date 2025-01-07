module 0x25c2420658340e8ab34f06343b917a952a9dad0e73776fa89160ea9a09494d82::eu {
    struct EU has drop {
        dummy_field: bool,
    }

    fun init(arg0: EU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EU>(arg0, 9, b"EU", b"America", b"Americaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT1uZv9rAINsYvvjuF64LiISjenoH3uQjpPpQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EU>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EU>>(v1);
    }

    // decompiled from Move bytecode v6
}

