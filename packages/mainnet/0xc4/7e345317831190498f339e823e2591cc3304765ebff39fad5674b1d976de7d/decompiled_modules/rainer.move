module 0xc47e345317831190498f339e823e2591cc3304765ebff39fad5674b1d976de7d::rainer {
    struct RAINER has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAINER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAINER>(arg0, 9, b"RAINER", b"RAINER COIN", b"RAINER IS HERE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/5BgEG0Y.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RAINER>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAINER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAINER>>(v1);
    }

    // decompiled from Move bytecode v6
}

