module 0x1cfa808a91faed3e38405f177648ed036b72779c685c2abc5a979ea930230fc5::tdk {
    struct TDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDK>(arg0, 6, b"TDK", b"TweeDick", b"No one knows if the cock or the balls were born first: We have been wondering forever here in the Dickverse.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_ec3b4156a7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TDK>>(v1);
    }

    // decompiled from Move bytecode v6
}

