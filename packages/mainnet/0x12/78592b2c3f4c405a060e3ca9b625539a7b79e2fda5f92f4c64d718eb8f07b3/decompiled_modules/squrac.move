module 0x1278592b2c3f4c405a060e3ca9b625539a7b79e2fda5f92f4c64d718eb8f07b3::squrac {
    struct SQURAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQURAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQURAC>(arg0, 6, b"SQURAC", b"Squrac on Sui", b"SQURAC is a combination of squirrel and raccoon, his father is peanut the convicted squirrel and his mother is convicted raccoon. They both met in jail.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib7zbwmzt32cjjvgquvrwrjgw2ase3kokvnb3h3ndhnukfznrtxn4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQURAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SQURAC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

