module 0x85f0afd0dffbcfc56b66808b0c713f4b6dc704402ac7e52bf538efb39c692a11::token24 {
    struct TOKEN24 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN24>, arg1: 0x2::coin::Coin<TOKEN24>) {
        0x2::coin::burn<TOKEN24>(arg0, arg1);
    }

    fun init(arg0: TOKEN24, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN24>(arg0, 9, b"li.fi", b"li.fi", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN24>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN24>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN24>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN24>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

