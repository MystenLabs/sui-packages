module 0x772265046fdea75e9b9d740785a517dcc7adac87bd1b54e51300b8f85bd8ccdd::van {
    struct VAN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<VAN>, arg1: 0x2::coin::Coin<VAN>) {
        0x2::coin::burn<VAN>(arg0, arg1);
    }

    fun init(arg0: VAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAN>(arg0, 6, b"VAN", b"CONVERSION", b"SUPERRARE COIN* I/WE ARE NOT LIABLE FOR ANY LOST FUNDS OR MISHAPS CAUSED BY THIS COIN OR THE ART USED TO MAKE IT. HAVE FUN PLAYING AND CONVERTING. PRO TIP!!! LOOK UP CONVERSION TABLES ONLINE!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiems6aoc6sdzqx4gqhlsklnsh2mubjyz5fbcwbeal3rszpdkood2m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAN>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<VAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<VAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

