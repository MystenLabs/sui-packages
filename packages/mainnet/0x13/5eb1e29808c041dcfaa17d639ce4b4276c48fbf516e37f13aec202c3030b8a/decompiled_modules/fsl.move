module 0x135eb1e29808c041dcfaa17d639ce4b4276c48fbf516e37f13aec202c3030b8a::fsl {
    struct FSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSL>(arg0, 6, b"FSL", b"First Sui Lord", b"First Sui Sea Lord - Captain of the ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Meme_1_1ee63f1250.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

