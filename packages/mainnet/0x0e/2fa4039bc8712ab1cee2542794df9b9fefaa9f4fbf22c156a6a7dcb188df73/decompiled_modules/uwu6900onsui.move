module 0xe2fa4039bc8712ab1cee2542794df9b9fefaa9f4fbf22c156a6a7dcb188df73::uwu6900onsui {
    struct UWU6900ONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UWU6900ONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UWU6900ONSUI>(arg0, 6, b"UWU6900ONSUI", b"UWU6900", b"$UWU6900 - The UWU6900 is a broad-based stock market index that tracks roughly 6900 anime gyatt girls in trenches.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_B_a_Wvu_S_400x400_62a55d2eb6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UWU6900ONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UWU6900ONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

