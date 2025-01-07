module 0x5a1f8821e99ee55f9a060b996f0dc511ea7c433877a9a7753eb871bda0e8c139::suicapys {
    struct SUICAPYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAPYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAPYS>(arg0, 6, b"SuiCapys", b"SUI CAPYS", b"The King Meme On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_15_13_15_56_3420bdefae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAPYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAPYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

