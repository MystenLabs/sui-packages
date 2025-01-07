module 0xf9da40d0d4a2af108288fe99b034e7c6938ba6a03dc05d4e1c819c2109091eed::golang {
    struct GOLANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLANG>(arg0, 6, b"Golang", b"Golang Sui", b"Funny meme cryptocurrency at sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b83362579b22774c072ab52e9b32fd81_80fe7408a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

