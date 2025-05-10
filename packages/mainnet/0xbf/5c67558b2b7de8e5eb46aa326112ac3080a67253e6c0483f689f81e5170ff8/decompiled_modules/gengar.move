module 0xbf5c67558b2b7de8e5eb46aa326112ac3080a67253e6c0483f689f81e5170ff8::gengar {
    struct GENGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENGAR>(arg0, 6, b"GENGAR", b"POKEMON GENGAR", x"5355494741522069732074686520666972737420706f6b656d6f6e205443472067616d65206f6e20746865200a405375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiegcpilu4l5izfezjy7aagx6kytx3hamz72gnyskk2bpnuhm2dady")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GENGAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

