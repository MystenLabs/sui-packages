module 0x6416bd03ff103890bcb4c6e3faffc1ad07fa4ed488a7103b74327fc8d760ac69::blg {
    struct BLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLG>(arg0, 6, b"BLG", b"Beluga", b"BELUGA'S Everythings About KING OF THE SEA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000210698_4bbcc73b2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLG>>(v1);
    }

    // decompiled from Move bytecode v6
}

