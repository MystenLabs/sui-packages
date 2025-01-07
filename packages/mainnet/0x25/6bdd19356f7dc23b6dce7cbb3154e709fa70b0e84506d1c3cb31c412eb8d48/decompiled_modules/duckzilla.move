module 0x256bdd19356f7dc23b6dce7cbb3154e709fa70b0e84506d1c3cb31c412eb8d48::duckzilla {
    struct DUCKZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKZILLA>(arg0, 6, b"Duckzilla", b"Duckzilla on SUI", b"Forget Godzilla. Forget King Kong. Forget everything you thought you knew about monster movies.This sweet little duckling but its the size of a skyscraper, and oh yeah, it shoots deadly laser beams from its eyes. You thought Godzilla was bad? Its nothing compared to Duckzilla.Dont let its looks fool you, Duckzilla decides to light here up with a quack-powered laser blast. One minute youre cooing aww, the next, your entire portfolio is up in flames (in a good way, maybe).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_7_J4_ZTXIAE_7r9_df541c4f50.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCKZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

