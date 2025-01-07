module 0xf9d0f5190f029cda57641f899f7138f23bf33908a769611640ba2b768a557e88::simi {
    struct SIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMI>(arg0, 6, b"SIMi", b"Sui Millionaires", b"We will make millionaires here on SUMI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010812_1407dcc53b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

