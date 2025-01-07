module 0xd94d67e21fcc39bf8d44140a1e3f9a589d711b35bcca390f5ea3346b895aafb9::hhs {
    struct HHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HHS>(arg0, 6, b"HHS", b"HAMMERHEAD SUI", b"The Coolest Shark on SUI ocean. hammerheadsui.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hh81fm7_400x400_bf82c51ec2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

