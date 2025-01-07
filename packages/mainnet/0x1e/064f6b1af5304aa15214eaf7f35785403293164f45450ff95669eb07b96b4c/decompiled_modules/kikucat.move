module 0x1e064f6b1af5304aa15214eaf7f35785403293164f45450ff95669eb07b96b4c::kikucat {
    struct KIKUCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIKUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIKUCAT>(arg0, 6, b"KIKUCAT", b"KIKU CATCOIN", x"4b696b7520436174206272696e677320612066756e20616e642072656c6178656420766962652c2061696d696e6720746f206d616b6520612062696720696d7061637420776974682069747320756e6971756520636861726d20616e6420616d626974696f757320676f616c732e204b696b7520436174206875676520706f74656e7469616c2072657475726e7320666f722069747320686f6c646572732e0a0a2068747470733a2f2f742e6d652f4b696b756f6e7375690a2068747470733a2f2f6b696b756361742e6c697665", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/296_B0307_CA_1_B_4_CEC_9011_065_EE_27_A1_E55_cd9f6ed1c1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIKUCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIKUCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

