module 0x41c4c8d5f532f64aa0c3cd16b8269fa35ad5676b01a577cc678320111f26fd75::cr7 {
    struct CR7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CR7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR7>(arg0, 6, b"CR7", b"CRISTIANO RONALDO 7", b"**CRISTIANO RONALDO 7 ($CR7)** is a community-driven token on the **Sui blockchain**, inspired by the legendary football icon Cristiano Ronaldo. Just as Ronaldo symbolizes passion, excellence, and global influence, $CR7 unites fans and crypto enthusi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1756215747219.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CR7>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR7>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

