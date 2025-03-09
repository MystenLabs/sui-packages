module 0x31ab0f06bef17b16be698fd9310b1090beec64b4f46d09720562d1976fa64bd3::wpepe {
    struct WPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WPEPE>(arg0, 6, b"WPEPE", b"WallstreetPePe", b"WPEPE is a Web3 meme token inspired by the character Pepe the Frog. The project combines fun with blockchain, attracting the community with its creativity and development potential.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/431b5ebf-560d-45be-bdda-073577638371.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

