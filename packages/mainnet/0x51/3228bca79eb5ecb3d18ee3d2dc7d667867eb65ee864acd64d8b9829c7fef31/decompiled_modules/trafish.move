module 0x513228bca79eb5ecb3d18ee3d2dc7d667867eb65ee864acd64d8b9829c7fef31::trafish {
    struct TRAFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAFISH>(arg0, 6, b"TRAFISH", b"Travis Scott Fish", b"$TRAFISH - Travis Scott Fish on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logooo_e47e4bc808.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRAFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

