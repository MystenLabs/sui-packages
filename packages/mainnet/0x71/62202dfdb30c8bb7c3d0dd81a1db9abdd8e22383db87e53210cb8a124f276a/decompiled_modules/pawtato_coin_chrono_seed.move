module 0x7162202dfdb30c8bb7c3d0dd81a1db9abdd8e22383db87e53210cb8a124f276a::pawtato_coin_chrono_seed {
    struct PAWTATO_COIN_CHRONO_SEED has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_CHRONO_SEED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_CHRONO_SEED>(arg0, 9, b"CHRONO_SEED", b"Pawtato Chrono Seed", b"Ancient seeds that manipulate the flow of time itself.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/chrono-seed.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_CHRONO_SEED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_CHRONO_SEED>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_chrono_seed(arg0: 0x2::coin::Coin<PAWTATO_COIN_CHRONO_SEED>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_CHRONO_SEED>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

