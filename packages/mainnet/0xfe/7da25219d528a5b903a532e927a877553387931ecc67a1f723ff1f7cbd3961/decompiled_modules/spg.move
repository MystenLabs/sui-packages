module 0xfe7da25219d528a5b903a532e927a877553387931ecc67a1f723ff1f7cbd3961::spg {
    struct SPG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPG>(arg0, 6, b"SPG", b"SUI ON PIGU", b"Navigating PIGU's world on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pigu_a897773828.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPG>>(v1);
    }

    // decompiled from Move bytecode v6
}

