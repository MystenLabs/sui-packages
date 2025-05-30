module 0xe4cf9c3676d5f35271f3df3eeefb7809f45982f58ed43428effea7b0b0c18313::hopper {
    struct HOPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPER>(arg0, 6, b"HOPPER", b"Hopper the Frog", x"57697468206869732074696e7920627261696e20616e64206769616e742068656172742c2024484f5050455220697320612066726f672065787472616f7264696e616972652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hopper_the_frog_logo_09aecbd85e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

