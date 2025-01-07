module 0x2f106d420791e1a6af27ce915d56b766c780295dc5a36f9cb3a9d4d314bdcb1b::dib {
    struct DIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIB>(arg0, 6, b"DIB", b"DevIsBroke", b"Help Dev to buy 1 $SUI (please)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dev_is_broke_df71995174.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

