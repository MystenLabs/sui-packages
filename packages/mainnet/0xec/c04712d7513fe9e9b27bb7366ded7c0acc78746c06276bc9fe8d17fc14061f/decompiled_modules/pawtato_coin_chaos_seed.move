module 0xecc04712d7513fe9e9b27bb7366ded7c0acc78746c06276bc9fe8d17fc14061f::pawtato_coin_chaos_seed {
    struct PAWTATO_COIN_CHAOS_SEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_CHAOS_SEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_CHAOS_SEED>(arg0, 9, b"CHAOS_SEED", b"Pawtato Chaos Seed", b"Mysterious seeds that contain chaotic energy from the void.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/chaos-seed.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_CHAOS_SEED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_CHAOS_SEED>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_chaos_seed(arg0: 0x2::coin::Coin<PAWTATO_COIN_CHAOS_SEED>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_CHAOS_SEED>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

