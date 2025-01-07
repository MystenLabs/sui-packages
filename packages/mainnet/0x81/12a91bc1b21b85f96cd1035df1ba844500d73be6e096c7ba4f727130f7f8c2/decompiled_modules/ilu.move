module 0x8112a91bc1b21b85f96cd1035df1ba844500d73be6e096c7ba4f727130f7f8c2::ilu {
    struct ILU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILU>(arg0, 6, b"ILU", b"I Love You", b"I Love You!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2358_85f6782580.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ILU>>(v1);
    }

    // decompiled from Move bytecode v6
}

