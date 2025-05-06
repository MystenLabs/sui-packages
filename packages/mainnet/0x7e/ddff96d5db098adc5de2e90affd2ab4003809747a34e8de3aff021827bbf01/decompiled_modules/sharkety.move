module 0x7eddff96d5db098adc5de2e90affd2ab4003809747a34e8de3aff021827bbf01::sharkety {
    struct SHARKETY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKETY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKETY>(arg0, 6, b"SHARKETY", b"Sharkety SUI", b"Explore the lore, evolution and story behind Shark Cat. SUI moves like SEA. SHARKETY is king of the sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihnqxzlvlt2jwysjqhars5tbbcmsiljqvkhn76k2ffspc2znbubo4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKETY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHARKETY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

