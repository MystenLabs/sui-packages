module 0x1fd2d676854a50a5394ecbe34b522e96879eb3aec96c1c2c25536e77439765de::hhs {
    struct HHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHS>(arg0, 6, b"HHS", b"HammerHead", b"The Coolest Shark on SUI ocean ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hh81fm7_400x400_43ecda7eba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

