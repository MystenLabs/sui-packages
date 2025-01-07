module 0xfb9e4e687415beea5a5788ae87e0c84f97e8216f6184ab364678f73b0e5fcfb8::byte {
    struct BYTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYTE>(arg0, 6, b"BYTE", b"BYTE on Sui", x"54686520317374202442595445206465706c6f796564206f6e205375692c20636f6d6d756e6974792d6d616e616765642e0a5468652068656972206170706172656e74202e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_O_O_U_U_O_U_9_c6622cfe04.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BYTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

