module 0x15bdff9baa3e07d83bb4693b29203b5db10cbd0eccf2613b2639cca1c5cc903c::pepecat {
    struct PEPECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPECAT>(arg0, 9, b"PEPECAT", b"PEPECAT", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPECAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPECAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

