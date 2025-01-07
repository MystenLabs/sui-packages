module 0x587b1102f1450e3733b93c69841e2e472ab78b5cc229e883cb4b20f54601824c::bw {
    struct BW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BW>(arg0, 2, b"BW", b"Blue Wizards", x"496e204d6964646c652d45617274682c2074686520706f776572206f6620746865204f6e652052696e67206d65726765732077697468205375692043727970746f2c207365637572696e6720746865207265616c6de2809973207765616c7468206f6e206120646563656e7472616c697a656420626c6f636b636861696e206265796f6e6420536175726f6ee28099732072656163682e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BW>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BW>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BW>>(v1);
    }

    // decompiled from Move bytecode v6
}

