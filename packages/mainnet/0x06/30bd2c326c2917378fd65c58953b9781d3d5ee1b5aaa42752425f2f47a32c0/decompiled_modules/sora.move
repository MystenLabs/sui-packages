module 0x630bd2c326c2917378fd65c58953b9781d3d5ee1b5aaa42752425f2f47a32c0::sora {
    struct SORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SORA>(arg0, 6, b"SORA", b"Sora on SUI", b"$Sora is on a mission to provide children with smiles all around the world. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_Juhy_KL_400x400_4c2a600461.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SORA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SORA>>(v1);
    }

    // decompiled from Move bytecode v6
}

