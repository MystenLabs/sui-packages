module 0x8b39abc93a17d85cb1a217f0ecdb3d811e25b2ea5875d55ad5538b3901bee731::sora {
    struct SORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SORA>(arg0, 6, b"SORA", b"Sora_On_Sui", b"$Sora is on a mission to provide children with smiles all around the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sora_ee6a9072be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

