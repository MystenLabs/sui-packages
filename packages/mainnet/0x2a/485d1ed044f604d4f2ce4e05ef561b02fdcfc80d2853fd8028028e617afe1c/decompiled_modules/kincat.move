module 0x2a485d1ed044f604d4f2ce4e05ef561b02fdcfc80d2853fd8028028e617afe1c::kincat {
    struct KINCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINCAT>(arg0, 6, b"KinCat", b"KinCat on SUI", b"Adventures of $KINCAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_CJGJ_Rji_400x400_27d2d02a3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

