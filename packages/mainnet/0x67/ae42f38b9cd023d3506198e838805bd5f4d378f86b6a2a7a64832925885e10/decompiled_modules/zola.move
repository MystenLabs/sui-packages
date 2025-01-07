module 0x67ae42f38b9cd023d3506198e838805bd5f4d378f86b6a2a7a64832925885e10::zola {
    struct ZOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOLA>(arg0, 6, b"ZOLA", b"Zola on SUI", x"546865206661737465737420416e696d616c206f6e20746865206661737465737420636861696e203d205a4f4c41206f6e205355490a0a4445562077616c6c657420697320676f6e6e61206265206275726e74", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cooking_80c107d3bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

