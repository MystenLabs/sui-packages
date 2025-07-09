module 0xde30f4a87e5c5d4ae83538110e6edd745ce7fd6c0c32f3e462018a971cb2f5d8::troomer {
    struct TROOMER has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TROOMER>, arg1: 0x2::coin::Coin<TROOMER>) {
        0x2::coin::burn<TROOMER>(arg0, arg1);
    }

    public entry fun destroy_treasury_cap(arg0: 0x2::coin::TreasuryCap<TROOMER>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROOMER>>(arg0, @0x0);
    }

    fun init(arg0: TROOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROOMER>(arg0, 6, b"TROOMER", b"Troomer", b"Troomer is the ultimate trencher, tirelessly tunneling through the blockchain in search of buried treasure Discord https://discord.gg/aRzwv7dY3v Twitter https://x.com/Troomer_?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/eyMfReI.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROOMER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROOMER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TROOMER>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TROOMER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

