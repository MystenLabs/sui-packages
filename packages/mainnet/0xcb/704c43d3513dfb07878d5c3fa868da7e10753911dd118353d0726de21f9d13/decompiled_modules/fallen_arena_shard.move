module 0xcb704c43d3513dfb07878d5c3fa868da7e10753911dd118353d0726de21f9d13::fallen_arena_shard {
    struct FALLEN_ARENA_SHARD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FALLEN_ARENA_SHARD>, arg1: 0x2::coin::Coin<FALLEN_ARENA_SHARD>) {
        0x2::coin::burn<FALLEN_ARENA_SHARD>(arg0, arg1);
    }

    fun init(arg0: FALLEN_ARENA_SHARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FALLEN_ARENA_SHARD>(arg0, 0, b"SHARD", b"Ambrus", b"Ambrus studio games weapon shards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://firebasestorage.googleapis.com/v0/b/blockus-prod.appspot.com/o/collections%2FdVK3SQnCNB846ZJTJGhIvxnuwaTU%2FE4C%20Fallen%20Arena%20Weapon%20Shard.png?alt=media&token=c3894b0e-6f11-437f-9cac-90e6ae776425")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FALLEN_ARENA_SHARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FALLEN_ARENA_SHARD>>(v0, @0x52d65824f5f4846531d9270ae179fb2caebc359cfdf731d7508236a20501bf14);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FALLEN_ARENA_SHARD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FALLEN_ARENA_SHARD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

