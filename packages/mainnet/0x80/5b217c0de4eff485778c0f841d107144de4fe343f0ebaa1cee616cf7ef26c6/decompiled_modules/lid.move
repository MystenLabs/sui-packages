module 0x805b217c0de4eff485778c0f841d107144de4fe343f0ebaa1cee616cf7ef26c6::lid {
    struct LID has drop {
        dummy_field: bool,
    }

    fun init(arg0: LID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LID>(arg0, 6, b"LID", b"SickLidWifNoBrim", b"Yooo, Yankee wif no brim!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008666_6f52afccdd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LID>>(v1);
    }

    // decompiled from Move bytecode v6
}

