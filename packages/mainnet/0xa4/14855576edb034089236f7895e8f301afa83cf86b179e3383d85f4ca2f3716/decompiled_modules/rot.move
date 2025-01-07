module 0xa414855576edb034089236f7895e8f301afa83cf86b179e3383d85f4ca2f3716::rot {
    struct ROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROT>(arg0, 6, b"ROT", b"brainrot", b"skibidi gyatt rizz mewing only in ohio with baby gronk vibes goon cave sigma grindset fanum taxed up to Caseoh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4dax_Dukp_400x400_ed9767c96e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

