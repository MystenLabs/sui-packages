module 0x23457715b1c9fdec420127070030cc26981b6c20f08f3945aeae9454398fd8d5::SECRET {
    struct SECRET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SECRET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SECRET>(arg0, 9, b"SECRET", b"SUI SECRET", b"SECRET", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1666938143310770182/8dh-CsgH_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SECRET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SECRET>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SECRET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SECRET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

