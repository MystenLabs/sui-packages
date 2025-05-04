module 0x903c664b64245ca43cbbfbb2204f7652f8e726532ae9b271f59feb73102572b0::view {
    struct VIEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIEW>(arg0, 9, b"View", b"Paperview", b"Exclusive content from $0.01 - $1,000,000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3f11000f27c3d0ba6e9fd63ba7a7cfdbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIEW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIEW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

