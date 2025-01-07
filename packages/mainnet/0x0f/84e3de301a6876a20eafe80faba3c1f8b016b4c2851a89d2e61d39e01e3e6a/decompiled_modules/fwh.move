module 0xf84e3de301a6876a20eafe80faba3c1f8b016b4c2851a89d2e61d39e01e3e6a::fwh {
    struct FWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWH>(arg0, 9, b"FWH", b"FudWithHat", b"gem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GCKvvLbWIAAELSv?format=jpg&name=small")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FWH>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

