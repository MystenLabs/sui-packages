module 0x4136a962c88200c24beea4b3683bc1ff6523b1f10aa6f11bbda7db46d0ad0e77::upy {
    struct UPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UPY>(arg0, 6, b"UPY", b"Up To You", b"Up to u and this market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rac_77e6d6db03.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

