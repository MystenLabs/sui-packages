module 0x8d8eca60baf32724138a7f4e2ec5633c5b33cfdb09b076f8b387a2018cf0f5ee::srm {
    struct SRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRM>(arg0, 6, b"SRM", b"Strategic Meme Reserve", b"Buidl the Reserve. Collect the Memes. Collect the Stories. Make the $SMR.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047940_2b8842b800.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

