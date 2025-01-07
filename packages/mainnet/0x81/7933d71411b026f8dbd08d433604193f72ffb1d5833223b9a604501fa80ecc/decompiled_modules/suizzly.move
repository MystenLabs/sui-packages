module 0x817933d71411b026f8dbd08d433604193f72ffb1d5833223b9a604501fa80ecc::suizzly {
    struct SUIZZLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZZLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZZLY>(arg0, 6, b"SUIZZLY", b"SUIZZLY BEAR", x"41206772697a7a6c792028245355495a5a4c5929202d706f6c61722d626561722d6879627269642069732061207261726520757273696420687962726964207468617420686173206f6363757272656420626f746820696e2063617074697669747920616e6420696e207468652077696c642e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3824_faa4d6dacd_942e96f59c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZZLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIZZLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

