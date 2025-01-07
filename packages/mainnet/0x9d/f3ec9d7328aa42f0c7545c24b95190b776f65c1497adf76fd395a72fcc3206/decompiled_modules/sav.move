module 0x9df3ec9d7328aa42f0c7545c24b95190b776f65c1497adf76fd395a72fcc3206::sav {
    struct SAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAV>(arg0, 6, b"SAV", b"SuiAvatar", b"It's a new world with Avatar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000100754_dc68f6d872.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

