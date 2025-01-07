module 0x2748d52cde1e628c30db983a92b7f956ed0b6dbcea1cb5a63ff0088882a0b775::luna {
    struct LUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUNA>(arg0, 6, b"LUNA", b"LUNA ON SUI", x"4c756e612c206f7572206a6f792c0a576974682065766572792070617720736865207472656164732c0a41206d656d65636f696e27732062697274682c0a57686572652068657220636861726d20737072656164732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_11_10_26_39_7ea257674f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

