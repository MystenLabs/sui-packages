module 0x9dcbaf4f4d85decc5556d8d1170e494b0fefcfd0de202db659586ffbca4591d2::sharkety {
    struct SHARKETY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKETY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKETY>(arg0, 6, b"SHARKETY", b"Sharkety", b"SHARKETY captures the fleeting attention span of the masses, embodying the short-term memory of a sharkety. Perfect for trend chasers and spontaneous degens. Here, spontaneity is rewarded!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_18_at_07_02_05_6220642bb6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKETY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKETY>>(v1);
    }

    // decompiled from Move bytecode v6
}

