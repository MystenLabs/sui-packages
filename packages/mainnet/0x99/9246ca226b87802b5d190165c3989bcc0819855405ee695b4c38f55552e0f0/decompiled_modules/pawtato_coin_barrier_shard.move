module 0x999246ca226b87802b5d190165c3989bcc0819855405ee695b4c38f55552e0f0::pawtato_coin_barrier_shard {
    struct PAWTATO_COIN_BARRIER_SHARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_BARRIER_SHARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_BARRIER_SHARD>(arg0, 9, b"BARRIER_SHARD", b"Pawtato Barrier Shard", b"Remnants of Axomamma's great Barrier which was shattered by Supay.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/barrier-shard.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_BARRIER_SHARD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_BARRIER_SHARD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_barrier_shard(arg0: 0x2::coin::Coin<PAWTATO_COIN_BARRIER_SHARD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_BARRIER_SHARD>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

