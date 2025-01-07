module 0x73e2712fa751ca5a80504def837442a4393810e4dbea38ed66c7dbdb30bf1d75::mj {
    struct MJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MJ>(arg0, 6, b"MJ", b"Majoson", b"hey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ef09df1d_fda9_46d2_b466_a010b6b1a91a_6b9e78a721.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

