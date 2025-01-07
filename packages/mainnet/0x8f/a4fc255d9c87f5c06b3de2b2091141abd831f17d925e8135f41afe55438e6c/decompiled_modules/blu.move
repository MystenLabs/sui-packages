module 0x8fa4fc255d9c87f5c06b3de2b2091141abd831f17d925e8135f41afe55438e6c::blu {
    struct BLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLU>(arg0, 9, b"BLU", b"Jewelz Blu", b"Jewelz Blu is the original cute mascot of the Sui blockchain ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.mds.yandex.net/i?id=a8dd712bce0c83fff1dda49aa7469fc71316e8d7-5878638-images-thumbs&n=13")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLU>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLU>>(v1);
    }

    // decompiled from Move bytecode v6
}

