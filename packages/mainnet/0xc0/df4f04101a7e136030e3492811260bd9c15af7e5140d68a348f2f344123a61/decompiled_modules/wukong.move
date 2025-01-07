module 0xc0df4f04101a7e136030e3492811260bd9c15af7e5140d68a348f2f344123a61::wukong {
    struct WUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUKONG>(arg0, 6, b"WUKONG", b"Baby Wukong", b"$BabyWukong inherits the legend of the Baby series and the indomitable spirit of Wukong, launching another revolution in the blockchain |Join now  :  https://www.babywukong.vip/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_photo_2024_09_05_05_12_30_180x180_91829f1d8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

