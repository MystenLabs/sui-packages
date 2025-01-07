module 0x50bd181cbf26216b8b67e2a60a2fd5517281296374bec7bd950417aa97c3cef3::melania {
    struct MELANIA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MELANIA>, arg1: 0x2::coin::Coin<MELANIA>) {
        0x2::coin::burn<MELANIA>(arg0, arg1);
    }

    fun init(arg0: MELANIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELANIA>(arg0, 9, b"Trump's Wife", b"MELANIA", b"Trump's Wife Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/Whale_Me_Logo_730916414f.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MELANIA>(&mut v2, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MELANIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIA>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MELANIA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MELANIA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

