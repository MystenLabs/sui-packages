module 0x5b53d197d276d8a41b87576f9796e76637cecfc8ba7890f7f7456aec47c1e56c::scn {
    struct SCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCN>(arg0, 6, b"SCN", b"SuicuneOnSui", b"The Legendary Beast of SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HQSUI_0e7c7cf912.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCN>>(v1);
    }

    // decompiled from Move bytecode v6
}

