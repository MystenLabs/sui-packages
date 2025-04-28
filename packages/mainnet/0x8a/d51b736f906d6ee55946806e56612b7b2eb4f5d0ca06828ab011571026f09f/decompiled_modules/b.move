module 0x8ad51b736f906d6ee55946806e56612b7b2eb4f5d0ca06828ab011571026f09f::b {
    struct B has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<B>, arg1: 0x2::coin::Coin<B>) {
        0x2::coin::burn<B>(arg0, arg1);
    }

    fun init(arg0: B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B>(arg0, 6, b"bgb", b"b", b"lalala", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.dreamstime.com%2Fillustration%2Fb-token.html&psig=AOvVaw3aGtuvWjr3ltFS3466Jb-d&ust=1745902791310000&source=images&cd=vfe&opi=89978449&ved=2ahUKEwj1uOPu-PmMAxWQq1YBHfLrHX8QjRx6BAgAEBk")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<B>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<B>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<B>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

