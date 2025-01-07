module 0xbac094c09982ebad44f3304988bb14a515fd57289778448af59f3182d22a0cf4::santacat {
    struct SANTACAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTACAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTACAT>(arg0, 9, b"SANTACAT", b"Spin Cat", x"5370696e20596f7572204261677320776974682053616e74614361742120f09f9088", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DU6eKdghQCiSmPJ9gUpecR9T7ufMmaBBCS3d77bspump.png?size=xl&key=472bf8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SANTACAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANTACAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTACAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

