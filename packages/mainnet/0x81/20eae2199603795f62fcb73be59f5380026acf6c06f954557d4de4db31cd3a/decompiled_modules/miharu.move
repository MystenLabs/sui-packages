module 0x8120eae2199603795f62fcb73be59f5380026acf6c06f954557d4de4db31cd3a::miharu {
    struct MIHARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIHARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIHARU>(arg0, 6, b"Miharu", b"SUIMiharu", x"54686520536d696c696e6720446f6c7068696e206d656d65206973206261736564206f662070686f746f206f66207468652046696e6c65737320506f72706f697365206e616d6564204d69686172750a737569206e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_79dd28ac23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIHARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIHARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

