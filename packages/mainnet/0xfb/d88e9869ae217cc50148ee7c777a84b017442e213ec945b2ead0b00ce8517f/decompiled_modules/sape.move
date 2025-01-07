module 0xfbd88e9869ae217cc50148ee7c777a84b017442e213ec945b2ead0b00ce8517f::sape {
    struct SAPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SAPE>, arg1: 0x2::coin::Coin<SAPE>) {
        0x2::coin::burn<SAPE>(arg0, arg1);
    }

    fun init(arg0: SAPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPE>(arg0, 6, b"SAPE", b"Sui APE", b"Twitter: @Puke2Earn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.seadn.io/gcs/files/49898cbc0574235fe1820f3db65aa08b.png?auto=format&w=40")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAPE>>(v1);
        0x2::coin::mint_and_transfer<SAPE>(&mut v2, 10000000000, 0x2::address::from_u256(49081472407194817422147482193596819345884407638953529932970525219145338348528), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPE>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SAPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SAPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

