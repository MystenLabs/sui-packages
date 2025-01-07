module 0x705d9d15bb73499eae274ed4de84faf099ed290546cdd5651930531fcb7f64b3::SKELETON {
    struct SKELETON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKELETON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKELETON>(arg0, 9, b"SKELETON", b"Skeleton", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdna.artstation.com/p/assets/images/images/081/030/248/large/valera-mankovskiy-squick666-skeleton-01.jpg?1729178754")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKELETON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SKELETON>>(0x2::coin::mint<SKELETON>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SKELETON>>(v2);
    }

    // decompiled from Move bytecode v6
}

