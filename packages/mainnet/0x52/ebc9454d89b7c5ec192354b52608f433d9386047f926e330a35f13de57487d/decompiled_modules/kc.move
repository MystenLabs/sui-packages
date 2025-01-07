module 0x52ebc9454d89b7c5ec192354b52608f433d9386047f926e330a35f13de57487d::kc {
    struct KC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KC>(arg0, 8, b"KC", b"KrakenCackle", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-0FFcO6qBTZ2sJEopD-mH0HcMKD6JIBJaEBVOr8lmovWDQweSoNIr6TmxN4jKu3h3wbs&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KC>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KC>>(v1);
    }

    // decompiled from Move bytecode v6
}

