module 0x64736b98c4a9796048da767bead165d4f29a0ad78d88f77acdffcf5a7fb2047f::penut {
    struct PENUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENUT>(arg0, 6, b"PENUT", b"Pepeanut on Sui", b"Only Heard of Pepe? Now Pepeanut is here ready to steal all your pinecones!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_p_transparent_192x192_2be91cecd4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

