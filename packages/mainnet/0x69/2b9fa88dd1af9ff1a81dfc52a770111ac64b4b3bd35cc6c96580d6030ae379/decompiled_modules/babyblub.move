module 0x692b9fa88dd1af9ff1a81dfc52a770111ac64b4b3bd35cc6c96580d6030ae379::babyblub {
    struct BABYBLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYBLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYBLUB>(arg0, 6, b"BABYBLUB", b"BABY BLUB", b"A dirty #babyBlub swims in the murky waters of the Sui Ocean, following my father, #Blub.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gif_c8ea669149.mp4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYBLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYBLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

