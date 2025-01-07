module 0x60552c5a1d7cca36a85cd4015a492a6ed5a1dcf3ddaa348c8cf3d0e915805f2a::suinions {
    struct SUINIONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIONS>(arg0, 9, b"SUINIONS", b"Suinions", b"Binions on Sui invading crypto to a new level of madness you've never seen before. Bananaaaaaaa!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x1cf1d706848966b702a371b41fcdc7bec6556766.png?size=xl&key=f48550")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUINIONS>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIONS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINIONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

