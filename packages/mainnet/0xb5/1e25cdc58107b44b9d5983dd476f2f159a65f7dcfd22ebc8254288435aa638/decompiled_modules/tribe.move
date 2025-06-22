module 0xb51e25cdc58107b44b9d5983dd476f2f159a65f7dcfd22ebc8254288435aa638::tribe {
    struct TRIBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIBE>(arg0, 6, b"Tribe", b"Tribe For Sui", b"TRIBE! TRIBE! TRIBE!\" Froggo croaked loudly, making the whole swamp ripple. \"Hear Froggo's prophecy! Soon, a new force will rise, bringing bright sunshine and the vitality of the Sui Network! That is... $TRIBE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigesimeofvkpzx4wdo7aqtaeaolywalis5w77izvpgkqqzxm7y5di")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRIBE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

