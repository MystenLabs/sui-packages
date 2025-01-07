module 0xe32920ba1d3885189babbb9cf4547f9a56c9d8ab923c78da2b838300097b0692::catsu {
    struct CATSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSU>(arg0, 6, b"CATSU", b"Cat Sui", b"Cat sui memecoin $CATSU  Is a community - driven cryptocurancy build around the theme of playful and mischievous cats", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241007_124542_139504668a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

