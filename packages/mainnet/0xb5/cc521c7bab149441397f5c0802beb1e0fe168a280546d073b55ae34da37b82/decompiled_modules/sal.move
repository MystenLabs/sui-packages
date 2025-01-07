module 0xb5cc521c7bab149441397f5c0802beb1e0fe168a280546d073b55ae34da37b82::sal {
    struct SAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAL>(arg0, 9, b"SAL", b"Salamander", b"Sal is a slimy salamander that will slither its way to the top of Degen Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/degenchain/0x460bc8cdb6e8c34d695e57dfb08a5bdfc2ff0d79.png?size=lg&key=97e5eb")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

