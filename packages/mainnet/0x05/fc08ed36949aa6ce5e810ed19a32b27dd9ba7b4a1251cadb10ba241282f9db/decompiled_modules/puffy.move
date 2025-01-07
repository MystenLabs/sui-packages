module 0x5fc08ed36949aa6ce5e810ed19a32b27dd9ba7b4a1251cadb10ba241282f9db::puffy {
    struct PUFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFY>(arg0, 6, b"PUFFY", b"PuffyonSui", x"50554646492049532054484520205055464645522046495348204f460a544845204d454d4520434f494e20574f524c442c0a4252494e47494e47205448452046554e20414e4420434841524d0a574954482049542e2049545320474f542054484520434f4f4c0a464143544f5220414e442020554e49515545205354594c452e0a4255494c54204f4e205448452053554920424c4f434b434841494e2c0a5055464649204953204845524520544f204d414b452057415645530a414e442050554d5020555020544845204d454d4520434f494e0a47414d452e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000259_51d7b26bd9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

