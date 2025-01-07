module 0xf4ef07a909861a630e5a837b92dce05f414c2dd81a5b5045d715eaf61bcf8081::suis {
    struct SUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIS>(arg0, 6, b"SUIS", b"Sui Sloth", b"Once upon a time in the lush, vibrant rainforest of Costa Rica, there lived a sloth named Suis. Unlike any other sloth, Suis was a brilliant shade of blue, a hue that sparkled like the ocean under the sun. His unusual color made him a bit of an outcast among the other sloths, who were content to hang in their green canopies, camouflaged among the leaves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bg_SX_Rxb_A_400x400_2b928f16d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

