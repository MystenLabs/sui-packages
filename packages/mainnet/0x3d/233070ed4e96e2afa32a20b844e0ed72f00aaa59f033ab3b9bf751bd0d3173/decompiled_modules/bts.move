module 0x3d233070ed4e96e2afa32a20b844e0ed72f00aaa59f033ab3b9bf751bd0d3173::bts {
    struct BTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTS>(arg0, 6, b"BTS", b"BITSUI", x"424954535549206973204d656d65636f696e206f6e205375692c776869636820697320696e73706972656420627920626974636f696e0a7468697320697320746865206669727374207374657020746f776172647320736f6d657468696e672068696768206c696b6520424954434f494e0a6265206f6e65206f66207468652042495453554920686f6c646572732066726f6d206e6f77206f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_10_06_at_03_27_24_d4eefdeb_ef92926919.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

