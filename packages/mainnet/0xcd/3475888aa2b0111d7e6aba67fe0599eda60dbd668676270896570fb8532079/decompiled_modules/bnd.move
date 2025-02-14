module 0xcd3475888aa2b0111d7e6aba67fe0599eda60dbd668676270896570fb8532079::bnd {
    struct BND has drop {
        dummy_field: bool,
    }

    fun init(arg0: BND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BND>(arg0, 6, b"BND", b"Broccoli Not Dog", b"Still fomo CZ's Broccoli? FUD IT! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/output_2_0e4c07feac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BND>>(v1);
    }

    // decompiled from Move bytecode v6
}

