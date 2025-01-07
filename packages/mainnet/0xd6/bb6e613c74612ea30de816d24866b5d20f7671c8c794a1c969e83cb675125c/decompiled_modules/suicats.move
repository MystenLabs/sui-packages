module 0xd6bb6e613c74612ea30de816d24866b5d20f7671c8c794a1c969e83cb675125c::suicats {
    struct SUICATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATS>(arg0, 9, b"SUICATS", b"Sui Cats", b"Suicats first Meme on sui network !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/Qmara5dGbj7yBQLMG3xXmGAuLTksRKwg9XPHk7up1EZBKh")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUICATS>(&mut v2, 111000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

