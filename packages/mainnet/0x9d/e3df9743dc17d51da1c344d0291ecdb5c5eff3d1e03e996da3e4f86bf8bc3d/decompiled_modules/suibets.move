module 0x9de3df9743dc17d51da1c344d0291ecdb5c5eff3d1e03e996da3e4f86bf8bc3d::suibets {
    struct SUIBETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBETS>(arg0, 9, b"suibets", b"suibets", b"Betting Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/58767ff0-0704-11f0-b264-5f08cd100cd6")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBETS>>(v1);
        0x2::coin::mint_and_transfer<SUIBETS>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBETS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

