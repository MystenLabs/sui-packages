module 0x4057efabcebeb92e20c9a4c50515527e012cc8d0539e1c22bdafb8a5b285666c::luckycalf {
    struct LUCKYCALF has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCKYCALF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCKYCALF>(arg0, 6, b"LUCKYCALF", b"Lucky Calf", b"This is a token created for the upcoming release of the Lucky Calf NFT. It has no value, and this is also to add some heat to the community in advance!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050400_d88950cd87.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKYCALF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUCKYCALF>>(v1);
    }

    // decompiled from Move bytecode v6
}

