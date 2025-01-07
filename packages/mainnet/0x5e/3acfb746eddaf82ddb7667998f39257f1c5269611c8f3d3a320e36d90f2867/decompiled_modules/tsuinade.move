module 0x5e3acfb746eddaf82ddb7667998f39257f1c5269611c8f3d3a320e36d90f2867::tsuinade {
    struct TSUINADE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSUINADE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSUINADE>(arg0, 9, b"TSUINADE", b"Tsuinade", b"Tsuuuuiinadeee join meme season", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/QmdWDAync3iSKLKYXa9YaXpWv7dHcAWC15t3e8bwZCWnmo")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TSUINADE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSUINADE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSUINADE>>(v1);
    }

    // decompiled from Move bytecode v6
}

