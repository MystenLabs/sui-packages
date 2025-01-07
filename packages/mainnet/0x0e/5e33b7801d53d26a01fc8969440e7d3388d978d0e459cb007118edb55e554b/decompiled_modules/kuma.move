module 0xe5e33b7801d53d26a01fc8969440e7d3388d978d0e459cb007118edb55e554b::kuma {
    struct KUMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUMA>(arg0, 6, b"KUMA", b"Monokuma", b"In the cryptoverse, where chaos reigns and memes conquer, emerges a force like no other  MonokumaCoin! Inspired by the enigmatic Monokuma from the Danganronpa universe,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_06_15_00_00_18_aaebd5beb4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

