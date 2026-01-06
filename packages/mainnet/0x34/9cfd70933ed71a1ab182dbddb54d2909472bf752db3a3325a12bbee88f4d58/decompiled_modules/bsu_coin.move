module 0x349cfd70933ed71a1ab182dbddb54d2909472bf752db3a3325a12bbee88f4d58::bsu_coin {
    struct BSU_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BSU_COIN>, arg1: 0x2::coin::Coin<BSU_COIN>) {
        0x2::coin::burn<BSU_COIN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BSU_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BSU_COIN>>(0x2::coin::mint<BSU_COIN>(arg0, arg1, arg3), arg2);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<BSU_COIN>) : u64 {
        0x2::coin::total_supply<BSU_COIN>(arg0)
    }

    fun init(arg0: BSU_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSU_COIN>(arg0, 9, b"BSU", b"Baby Shark Universe", b"Baby Shark Universe Token - Bridged via LayerZero", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.coingecko.com/coins/images/37082/standard/bsu.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSU_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSU_COIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

