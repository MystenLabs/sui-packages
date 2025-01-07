module 0x2d3b178ed1695263ea6fee7b0a04fce542ea035c41659d1436e7cee907bf1236::snus {
    struct SNUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUS>(arg0, 6, b"SNUS", b"SUISUINUS", x"546f6b656e2061626f7574207468652066616d6f757320696e76656e74696f6e206f66207468652073616d65206e616d6520534e55530a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241011_065659_225_4cbb739d2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

