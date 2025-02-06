module 0xe6f7478d1827cd92de8e175be4356cf8a96171d4825034017ee1778b9abc44d::ooii {
    struct OOII has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOII>(arg0, 9, b"OOII", b"AD", b"sddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.thenounproject.com/png/447685-200.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OOII>>(v1);
    }

    // decompiled from Move bytecode v6
}

