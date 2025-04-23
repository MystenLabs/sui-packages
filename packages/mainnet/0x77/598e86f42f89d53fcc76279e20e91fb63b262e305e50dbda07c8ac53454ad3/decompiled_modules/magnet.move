module 0x77598e86f42f89d53fcc76279e20e91fb63b262e305e50dbda07c8ac53454ad3::magnet {
    struct MAGNET has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MAGNET>, arg1: 0x2::coin::Coin<MAGNET>) {
        0x2::coin::burn<MAGNET>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MAGNET>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MAGNET>>(0x2::coin::mint<MAGNET>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: MAGNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGNET>(arg0, 6, b"Magnet", b"Magnet Coin", b"Magnet Chain Native Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeidhicntnpxfkvompdcfveoq7i56izck7gmdueikzfzcaqkicgkb3y.ipfs.w3s.link/%E6%88%AA%E5%B1%8F2025-04-10%2015.11.29.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGNET>>(v1);
        let v3 = &mut v2;
        mint(v3, 210000000000000, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNET>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

