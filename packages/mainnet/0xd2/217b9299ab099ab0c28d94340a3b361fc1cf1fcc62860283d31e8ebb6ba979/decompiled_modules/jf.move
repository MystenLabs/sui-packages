module 0xd2217b9299ab099ab0c28d94340a3b361fc1cf1fcc62860283d31e8ebb6ba979::jf {
    struct JF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JF>(arg0, 8, b"JF", b"JellyFish", b".", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJ4xE0iaHo2F5shPJ-OBkXWzMdZx6C2bM9tg&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JF>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JF>>(v1);
    }

    // decompiled from Move bytecode v6
}

