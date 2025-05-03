module 0x48f5e5890221f93f56c55d7a67a1aeb9e42a378d91b5272567ffd0f98500e39c::atoll {
    struct ATOLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATOLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATOLL>(arg0, 6, b"ATOLL", b"ATOLL THE AMPHIBIAN", b"the hallucinogenic amphibian riding the highs of crypto! Always deep in the degen grind, always seeing charts in psychedelic colors. Whether the market is up or down, this amphibian is vibing in another dimension. Hop in, trip out, and let $ATOLL take you on a wild ride!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ATOLLPP_536f2293b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATOLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATOLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

