module 0x53e08352ca040fea913ba23f4634de17f9289437b4adecbe002c63de1d9cce79::beth {
    struct BETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETH>(arg0, 9, b"BETH", b"BETHAI", b"BETH AI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1876346435769077760/VMSkrSvB_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BETH>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

