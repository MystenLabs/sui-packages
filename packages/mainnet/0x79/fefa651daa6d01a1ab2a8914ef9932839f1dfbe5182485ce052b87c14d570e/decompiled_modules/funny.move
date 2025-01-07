module 0x79fefa651daa6d01a1ab2a8914ef9932839f1dfbe5182485ce052b87c14d570e::funny {
    struct FUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNNY>(arg0, 6, b"FUNNY", b"FUNNY the Bunny", b"What do you call a rabbit without legs? It doesn't matter... he's not coming anyway. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_Ic5m83_400x400_800a3056d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

