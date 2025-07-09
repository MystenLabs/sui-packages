module 0x6ac87edeef5071d4951ccc7cdaf860d1d0cee6eba8479fbffe655f314645aafc::suivysaur {
    struct SUIVYSAUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVYSAUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVYSAUR>(arg0, 9, b"IVYSUI", b"Suivysaur", b"A lizard with leafy wings, tail wrapped in Sui vines, flowers blooming Sui droplets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/TO_BE_UPDATED")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIVYSAUR>(&mut v2, 1000000000000000000, @0x86428776defb6b37e4039efdd64fb1284e144171ea5b7b6821ab171043731cce, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVYSAUR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVYSAUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

