module 0xeceb20b898c94c68fada9a04d52060a6226d0b80625973a3329f71304096a272::b_brn {
    struct B_BRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BRN>(arg0, 9, b"bBRN", b"bToken BRN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

