module 0x994f7dc1864dc7f043ff67d03cd39f4492d90b7ac956155600f3f79fb14a8c90::coin1 {
    struct COIN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN1>(arg0, 9, b"coin", b"coin1", b"coin is here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/9366d846-6b75-4b32-a233-199d8f3f2e79.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

