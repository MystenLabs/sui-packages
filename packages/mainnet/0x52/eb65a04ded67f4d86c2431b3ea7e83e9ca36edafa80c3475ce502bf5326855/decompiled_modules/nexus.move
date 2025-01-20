module 0x52eb65a04ded67f4d86c2431b3ea7e83e9ca36edafa80c3475ce502bf5326855::nexus {
    struct NEXUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEXUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEXUS>(arg0, 6, b"Nexus", b"Nexus OS", b"Nexus OS is your all-in-one blockchain intelligence platform powered by cutting-edge technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2185_4a43814790.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEXUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEXUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

