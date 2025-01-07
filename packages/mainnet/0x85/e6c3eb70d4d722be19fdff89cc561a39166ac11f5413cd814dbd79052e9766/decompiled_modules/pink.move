module 0x85e6c3eb70d4d722be19fdff89cc561a39166ac11f5413cd814dbd79052e9766::pink {
    struct PINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINK>(arg0, 6, b"PINK", b"First Pink Pepe on Sui", b"The most memeable memecoin in existence,but pink version", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_01_66fcfee2f6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

