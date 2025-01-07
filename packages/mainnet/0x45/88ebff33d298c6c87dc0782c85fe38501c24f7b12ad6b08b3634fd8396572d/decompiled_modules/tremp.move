module 0x4588ebff33d298c6c87dc0782c85fe38501c24f7b12ad6b08b3634fd8396572d::tremp {
    struct TREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TREMP>(arg0, 6, b"Tremp", b"Doland Tremp", b"meme Donald Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0dad0761_cab4_4d7f_a258_2f061de8c387_857fb51445.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

