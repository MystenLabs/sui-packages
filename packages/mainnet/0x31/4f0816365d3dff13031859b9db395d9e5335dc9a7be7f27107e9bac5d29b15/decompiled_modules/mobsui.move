module 0x314f0816365d3dff13031859b9db395d9e5335dc9a7be7f27107e9bac5d29b15::mobsui {
    struct MOBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBSUI>(arg0, 6, b"MOBSUI", b"MobSuiOFC", b"The Greatest Whale of all time is coming to the Ocean of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_17_06_03_26_c1a3c993e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

