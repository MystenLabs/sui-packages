module 0x5bd08423e8bdfd7c86058d6f91f53d06a43a41266130256fd49ebfd3e52b301d::sbunny {
    struct SBUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBUNNY>(arg0, 6, b"SBUNNY", b"Bunny On Sui", b"$SUIBUNNY is the latest sensation in the memecoin universe, bringing laughter and lighthearted fun to the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bunny2_97d57ac635_e3848c1b55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBUNNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

