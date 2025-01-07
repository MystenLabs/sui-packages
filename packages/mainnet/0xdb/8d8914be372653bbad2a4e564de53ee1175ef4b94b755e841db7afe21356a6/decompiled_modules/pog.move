module 0xdb8d8914be372653bbad2a4e564de53ee1175ef4b94b755e841db7afe21356a6::pog {
    struct POG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POG>(arg0, 8, b"POG", b"Poseidog", b"Poseidollar meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JEUZ2iF.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POG>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POG>>(v1);
    }

    // decompiled from Move bytecode v6
}

