module 0xe0eea77fde2802daddb6d1c8778575365aae099bc7d207d7197f3a645377df1f::dad {
    struct DAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAD>(arg0, 6, b"DAD", b"Are you winning, SON?", b"The meme pokes fun at the generation gap or the obliviousness of parents toward their children's hobbies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dad_ae1417c3a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

