module 0xddf6550844727f14e8a1f89eb6efd2cd7fe505e9ede5ba56508e2d0cde18962e::sujakk {
    struct SUJAKK has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUJAKK>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUJAKK>>(0x2::coin::mint<SUJAKK>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: SUJAKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUJAKK>(arg0, 9, b"SUJAKK", b"SUJAKK", b"Real world of SUJAK iconic meme character", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUJAKK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUJAKK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUJAKK>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

