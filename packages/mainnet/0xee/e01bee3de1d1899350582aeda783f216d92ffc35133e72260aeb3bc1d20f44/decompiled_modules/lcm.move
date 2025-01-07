module 0xeee01bee3de1d1899350582aeda783f216d92ffc35133e72260aeb3bc1d20f44::lcm {
    struct LCM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCM>(arg0, 6, b"LCM", b"Life Changing Money", b"This is $LCM. Buying LCM on Sui is the way to change your life forever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050522_c4df7c9fba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LCM>>(v1);
    }

    // decompiled from Move bytecode v6
}

