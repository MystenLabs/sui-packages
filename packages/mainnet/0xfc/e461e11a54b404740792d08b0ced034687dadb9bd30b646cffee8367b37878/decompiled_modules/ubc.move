module 0xfce461e11a54b404740792d08b0ced034687dadb9bd30b646cffee8367b37878::ubc {
    struct UBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: UBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UBC>(arg0, 6, b"UBC", b"Unicorn Butthole Coin", x"556e69636f726e2042757474686f6c6520436f696e20245542430a0a796f752063616e2774206861766520756e69636f726e20666172747320776974686f7574206120756e69636f726e2062757474686f6c650a0a74673a20742e6d652f756e69636f726e62757474686f6c650a7765623a20756e69636f726e62757474686f6c652e636f6d0a783a20782e636f6d2f756e69636f726e62757474636f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_163435_027_8b87eba058.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

