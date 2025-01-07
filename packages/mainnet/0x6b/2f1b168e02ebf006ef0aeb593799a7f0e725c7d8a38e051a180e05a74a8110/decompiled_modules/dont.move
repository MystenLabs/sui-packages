module 0x6b2f1b168e02ebf006ef0aeb593799a7f0e725c7d8a38e051a180e05a74a8110::dont {
    struct DONT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONT>(arg0, 6, b"DonT", b"Donump Trald", x"446f6e756d70205472616c64206973206f6e20737472696b65206f6e20535549200a0a2d204e6f20736f6369616c732c204a75737420446f6e756d70205472616c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/56b336fe7385ab5028bb60102e16bf02_595461c5a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONT>>(v1);
    }

    // decompiled from Move bytecode v6
}

