module 0xe54cb41c89fc0f9d2eecea135052ac67950fde05fbc33a52c05311141c185fc4::rbt {
    struct RBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBT>(arg0, 9, b"RBT", b"ROBOTS", b"100", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/96035498f5b8089d668fffd4a8a9754ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

