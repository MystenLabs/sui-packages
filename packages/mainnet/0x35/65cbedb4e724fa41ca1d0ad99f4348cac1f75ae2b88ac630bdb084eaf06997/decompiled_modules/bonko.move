module 0x3565cbedb4e724fa41ca1d0ad99f4348cac1f75ae2b88ac630bdb084eaf06997::bonko {
    struct BONKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKO>(arg0, 6, b"BONKO", b"Bonko", b"The BONKO movement is like no other on the Blockchain, bringing dog lovers from all around the crypto space and uniting them into one.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1725854490229_9dc640289d78ffe60eaf26e0b16da4af_05e7b39a92.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

