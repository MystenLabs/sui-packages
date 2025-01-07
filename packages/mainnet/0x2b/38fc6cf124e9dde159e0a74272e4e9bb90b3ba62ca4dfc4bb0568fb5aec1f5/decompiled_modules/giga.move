module 0x2b38fc6cf124e9dde159e0a74272e4e9bb90b3ba62ca4dfc4bb0568fb5aec1f5::giga {
    struct GIGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGA>(arg0, 9, b"GIGA", b"$GigaSui", b"This is the $Gigachad of Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.wikia.nocookie.net/joke-battles/images/d/df/Gigachad.png/revision/latest?cb=20230812064835")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GIGA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

