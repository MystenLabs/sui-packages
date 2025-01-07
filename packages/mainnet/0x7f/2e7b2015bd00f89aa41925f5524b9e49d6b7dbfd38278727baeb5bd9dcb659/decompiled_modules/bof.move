module 0x7f2e7b2015bd00f89aa41925f5524b9e49d6b7dbfd38278727baeb5bd9dcb659::bof {
    struct BOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOF>(arg0, 9, b"BOF", b"Balls of Fate", b"Balls of Fate: Cryptocurrency with Sui character. And balls", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1840347401602637824/WKidb2XE_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

