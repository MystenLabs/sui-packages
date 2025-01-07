module 0x797e0ddc4c88abafc5013813892c27abe872e08f6a60fa35a7fd6e2ecfd36ee2::sun {
    struct SUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUN>(arg0, 6, b"SUN", b"SuiShine", x"4c6574205375697368696e65207761726d20796f752c20616e642074616b6520697420746f207468652053756e20210a0a416c6c20736f6369616c2063726561746564207768656e2066696c6c65642e0a496620746869732074616b65206f75742c20666972737420746f6b656e20676f6e6e612062652073656c6c20666f722070616964206465782e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/56_EB_448_B_AEC_8_4_CDA_949_F_9_CCA_517_E0_D14_e22a2900ff.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

