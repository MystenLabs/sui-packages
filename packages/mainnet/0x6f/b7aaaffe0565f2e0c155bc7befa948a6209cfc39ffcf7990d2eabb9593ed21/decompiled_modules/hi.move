module 0x6fb7aaaffe0565f2e0c155bc7befa948a6209cfc39ffcf7990d2eabb9593ed21::hi {
    struct HI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HI>(arg0, 9, b"Hi", b"miyp", b"cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a0cc7ec99dbdf2479d1cf8d1c68f5f0bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

