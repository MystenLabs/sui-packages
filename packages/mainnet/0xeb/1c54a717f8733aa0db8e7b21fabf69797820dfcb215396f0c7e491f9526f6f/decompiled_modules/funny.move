module 0xeb1c54a717f8733aa0db8e7b21fabf69797820dfcb215396f0c7e491f9526f6f::funny {
    struct FUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNNY>(arg0, 6, b"FUNNY", b"FUNNY the BUNNY", b"What do you call a rabbit without legs? It doesn't matter... he's not coming anyway. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_Ic5m83_400x400_46d9476cbf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

