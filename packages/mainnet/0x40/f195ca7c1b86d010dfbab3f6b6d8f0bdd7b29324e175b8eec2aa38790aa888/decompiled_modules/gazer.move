module 0x40f195ca7c1b86d010dfbab3f6b6d8f0bdd7b29324e175b8eec2aa38790aa888::gazer {
    struct GAZER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAZER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAZER>(arg0, 9, b"GAZER", b"Sui Gazer", b"Don't worry - he'll just watch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmceKGiwcXnoapbmkKEL5hPYjct9MAz4K97EkBAoQ5rvJV?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GAZER>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAZER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAZER>>(v1);
    }

    // decompiled from Move bytecode v6
}

