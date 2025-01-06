module 0xfa123f988297dedeccb3f6aa9fdf3dd773bd35ba0f21240ee984ac88aec9ca8b::h {
    struct H has drop {
        dummy_field: bool,
    }

    fun init(arg0: H, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H>(arg0, 9, b"H", b"HENG", b"HENGHENGHENGHENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cb809befbbff9a006c4daad6ea67295eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<H>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

