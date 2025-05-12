module 0xb7cde87c194a7748e196546ce037d852093540da6ddc38ee896fdba99e64120e::ashsui {
    struct ASHSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASHSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASHSUI>(arg0, 6, b"ASHSUI", b"Ash On Sui", b"Gonna catch dem all pokemons on SUI Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibcky7wcla6llrv2t4cx7nqq2sry75aqpuuaxdi2udlytlyuk35oy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASHSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASHSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

