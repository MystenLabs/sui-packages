module 0x5934f678846428d4d723788dc49a258301b240eac22221f683d16741982219fc::mia {
    struct MIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIA>(arg0, 9, b"MIA", b"miaV", b"super coin mia V", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/dc4916ce082e8b52603f057cc30bfaeeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

