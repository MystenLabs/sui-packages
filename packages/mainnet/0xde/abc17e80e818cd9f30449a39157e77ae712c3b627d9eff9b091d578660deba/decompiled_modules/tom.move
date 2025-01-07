module 0xdeabc17e80e818cd9f30449a39157e77ae712c3b627d9eff9b091d578660deba::tom {
    struct TOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOM>(arg0, 4, b"TOM", b"Tom Spongebob", b"Go on a new journey with TOM at $SUI Ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiezdcmlnmdjtb37rnwn6q7oe2cpfzbhn7vepxlol3ft2mzddyvpzy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOM>(&mut v2, 6904200000000000000, @0xe83f22bc0f57d7553986655751548435e8409c262bae2bf52a0951a2bb10f4e9, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOM>>(v2, @0xe83f22bc0f57d7553986655751548435e8409c262bae2bf52a0951a2bb10f4e9);
    }

    // decompiled from Move bytecode v6
}

