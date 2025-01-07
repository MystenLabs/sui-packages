module 0xe11e37acb27b6de17e2cab5b8f4d0f71abdc986657de49a1ba11e4dbae2f6239::fishio {
    struct FISHIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHIO>(arg0, 9, b"FISHIO", b"Fishio", b"Glup glup", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnyXxQvma_x9D-CUXbp5_meFAoTOrLhBPn3Q&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FISHIO>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHIO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

