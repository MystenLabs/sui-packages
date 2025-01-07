module 0x67cd02790b4386222836e32ff790a608df0a22b32a668370286eae72cef91a3a::dimbo {
    struct DIMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIMBO>(arg0, 6, b"DIMBO", b"DIMBO", b"Road from 0 to 10 million!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media1.tenor.com/m/3WIJzilMReoAAAAC/jumbo-srajumbo.gif")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DIMBO>(&mut v2, 500000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIMBO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

