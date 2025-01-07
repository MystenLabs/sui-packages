module 0x25818a706ca4acc1c1d9df73271ba42e3833e5e79f9735209a9d0445c5b88e22::neiroonsui {
    struct NEIROONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIROONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIROONSUI>(arg0, 9, b"NeiroOnSui", b"Neiro On Sui", b"$NEIRO on Sui. The new Shiba Inu dog, successor to the Doge dog after her passing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://teal-deliberate-skunk-670.mypinata.cloud/ipfs/QmScFngDtLwctCDe6yGUmFHFG9WVvP5r3TKU8uZ79v16Ed")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEIROONSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIROONSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIROONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

