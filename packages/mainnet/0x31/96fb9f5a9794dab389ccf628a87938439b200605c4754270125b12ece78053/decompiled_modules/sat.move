module 0x3196fb9f5a9794dab389ccf628a87938439b200605c4754270125b12ece78053::sat {
    struct SAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAT>(arg0, 6, b"SAT", b"SEAL CAT", b"Its a seal cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SAT_b18f7f6f6e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

