module 0x9f248efea1c8309b5380bb2c77598fa972088b02f47eab72653bb16ac1d8cd9c::bes {
    struct BES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BES>(arg0, 6, b"BES", b"BigEyeOnSui", b"Pump pump just pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8af1c396_a7c0_45ad_acdb_e57ec6d7a872_3086b508e9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BES>>(v1);
    }

    // decompiled from Move bytecode v6
}

