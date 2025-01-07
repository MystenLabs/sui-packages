module 0x20467d1267b8d3ee806b223ed7b0918d831d5b20b96006574c74a831b2d8f73::brian {
    struct BRIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRIAN>(arg0, 9, b"BRIAN", b"Brian Griffin", b"$BRIAN from Family Guy by Seth MacFarlane  [ https://x.com/BRIAN_SUICHAIN ]  [ https://briangriffin.fun ]  [ https://t.me/BRIAN_SUICHAIN ]", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/briansuichain/brian/refs/heads/main/Brian%20Logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRIAN>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRIAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

