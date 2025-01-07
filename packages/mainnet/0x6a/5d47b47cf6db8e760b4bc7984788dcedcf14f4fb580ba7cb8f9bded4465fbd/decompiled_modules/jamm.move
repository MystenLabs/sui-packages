module 0x6a5d47b47cf6db8e760b4bc7984788dcedcf14f4fb580ba7cb8f9bded4465fbd::jamm {
    struct JAMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAMM>(arg0, 6, b"JAMM", b"Sui Catjam", x"54686520766962652061626f757420244a414d0a0a2249206e657665722061736b206d7920636c69656e747320746f206a7564676520244a414d206f6e20697427732070726963652c20492061736b207468656d20746f206a75646765206974206f6e206966206974206a616d7320696e20796f75722077616c6c65742062656361757365206974206e657665722073746f7073206a616d6d696e672e22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0103_9e0d4adf8d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

