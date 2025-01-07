module 0x26cf0af540958d3b4b6ef0a2e71140bdce691054cace98fa44f0dedf4dd6c808::starfish {
    struct STARFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARFISH>(arg0, 9, b"STARFISH", b"Sui Starfish", b"Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://t.me/suistarfishreal")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STARFISH>(&mut v2, 650000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARFISH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

