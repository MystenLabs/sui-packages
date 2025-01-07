module 0x97ef6244c42ae1b51d30f92fe3b6b3e997d899458ef70647ac165583e76de3::pipo {
    struct PIPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPO>(arg0, 6, b"PIPO", b"PIPO on SUI", b"PIPO meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7o3c5j84_400x400_40587f6a63.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

