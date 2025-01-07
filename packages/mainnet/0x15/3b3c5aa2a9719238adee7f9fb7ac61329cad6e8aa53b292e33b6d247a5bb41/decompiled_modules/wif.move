module 0x153b3c5aa2a9719238adee7f9fb7ac61329cad6e8aa53b292e33b6d247a5bb41::wif {
    struct WIF has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WIF>, arg1: 0x2::coin::Coin<WIF>) {
        0x2::coin::burn<WIF>(arg0, arg1);
    }

    fun init(arg0: WIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIF>(arg0, 4, b"WIF", b"WIF", b"A DOG WIF A HAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dogwifcoin.org/wp-content/uploads/2023/11/wif_logo-e1700717636910.jpg")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0xf518a3cd1a0f7c73fa6d2ba862a847f7a9a357b05f84d039c5bbb40a04bde912, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIF>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WIF>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<WIF>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WIF>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

