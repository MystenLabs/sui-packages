module 0xd51814f4ec54bba309b5450eb921d033562da79ffdf7e42713ab11f5c8bbc9f8::puggy {
    struct PUGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGGY>(arg0, 6, b"Puggy", b"PuggyOnSui", x"5055474759444f4720697320746865206d6f737420636f6f6c65737420616e64206472697070696e272064617767206f6e0a537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiflvz3ey5vg2fpmiicc2y3ncmquyiw77vm3zdoqllf6oskqp2nhou")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUGGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

