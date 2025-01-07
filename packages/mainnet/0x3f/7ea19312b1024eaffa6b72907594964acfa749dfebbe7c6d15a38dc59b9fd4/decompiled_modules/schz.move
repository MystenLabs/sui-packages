module 0x3f7ea19312b1024eaffa6b72907594964acfa749dfebbe7c6d15a38dc59b9fd4::schz {
    struct SCHZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHZ>(arg0, 6, b"SCHZ", b"SUI CHORIZO", b"THIS CHORIZO SALAM IS THE BEST ON THE F.KING WORLD GUYS COME AND TASTE THIS AMAZING BEAUTIFUL CHORIZOOOOOOOOOOOOOOOOOOOOOOOOOO FROM SUUUUUUUUUUUUUUUUIIIIIIIIIIIIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/zas_12d96afe2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

