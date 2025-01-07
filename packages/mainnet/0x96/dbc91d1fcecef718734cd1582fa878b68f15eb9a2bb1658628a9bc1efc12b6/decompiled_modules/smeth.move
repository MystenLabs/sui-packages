module 0x96dbc91d1fcecef718734cd1582fa878b68f15eb9a2bb1658628a9bc1efc12b6::smeth {
    struct SMETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMETH>(arg0, 6, b"SMETH", b"Sui meth", x"4865792074686572652120496d20537569204d6574682c2062757420796f752063616e2063616c6c206d652024534d4554482e0a0a496d206e6f74206a75737420616e7920746f6b656e2c20496d20746865206c696665206f6620746865207061727479206f6e2074686520537569204e6574776f726b2e20426f726e2066726f6d2061206c6f7665206f66206d656d657320616e64206120737072696e6b6c65206f66206d6f6f6e73686f74206d616769632c20496d206865726520746f207368616b65207468696e677320757020616e64206d616b65207468652063727970746f20737061636520776179206d6f72652066756e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_12_05_01_56_45_Create_a_more_natural_looking_cartoon_illustration_of_a_transparent_zip_bag_filled_with_light_blue_shattered_crystals_The_bag_should_look_realistic_225a72dcec.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

