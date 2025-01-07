module 0x9d8162a519feb1d7f83fed6f8823961ef251dbbe91bd2c77013c4a69c9eb613d::snapcat {
    struct SNAPCAT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SNAPCAT>, arg1: 0x2::coin::Coin<SNAPCAT>) {
        0x2::coin::burn<SNAPCAT>(arg0, arg1);
    }

    fun init(arg0: SNAPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAPCAT>(arg0, 9, b"SNAPCAT", b"SNAPCAT", b"Snapcat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/ELnAjNJJRBaG9MnnZqUXLsbBjkVA19szcduNeD5RCqdo.png")), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 1000000000000000, @0x4fe4463e6038e12758c6f29a82596aa9ed6920dde8c0f322ab67bbe7dd67bf0a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNAPCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAPCAT>>(v2, @0x4fe4463e6038e12758c6f29a82596aa9ed6920dde8c0f322ab67bbe7dd67bf0a);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SNAPCAT>, arg1: u128, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SNAPCAT>(arg0, (arg1 as u64), arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

