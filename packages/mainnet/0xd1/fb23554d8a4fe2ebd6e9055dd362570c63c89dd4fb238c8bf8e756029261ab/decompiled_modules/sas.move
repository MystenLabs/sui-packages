module 0xd1fb23554d8a4fe2ebd6e9055dd362570c63c89dd4fb238c8bf8e756029261ab::sas {
    struct SAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAS>(arg0, 9, b"SAS", b"SaS", b"Sun And Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://science.nasa.gov/wp-content/uploads/2023/05/pia03149-copy.jpg?w=1024")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAS>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

