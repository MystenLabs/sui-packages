module 0xf1649cfe190d3df5305970fabad18b9fd19622cca63639ff5a27e04e6908537d::chipt {
    struct CHIPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIPT>(arg0, 6, b"CHIPT", b"Chill Pepe On Sui", b"Chill Pepe Thug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_25_at_11_02_58_bbbd5241_3f3707fd49.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

