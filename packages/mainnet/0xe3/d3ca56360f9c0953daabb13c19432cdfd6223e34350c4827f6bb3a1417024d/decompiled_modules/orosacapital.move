module 0xe3d3ca56360f9c0953daabb13c19432cdfd6223e34350c4827f6bb3a1417024d::orosacapital {
    struct OROSACAPITAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: OROSACAPITAL, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 666 || 0x2::tx_context::epoch(arg1) == 667, 1);
        let (v0, v1) = 0x2::coin::create_currency<OROSACAPITAL>(arg0, 9, b"OCAPX", b"OrosaCapital", x"4f4341505820546f6b656e3a20456c65766174696e672044654669204c6971756964697479206f6e205355490a546865204f4341505820546f6b656e20697320746865206e617469766520746f6b656e206f66204f726f7361204361706974616c0a64657369676e656420746f20656e68616e6365206c6971756964697479206f6e2074686520536f6c616e6120626c6f636b636861696e2e200a576974682061206d6178696d756d20737570706c79206f662074656e206d696c6c696f6e20746f6b656e732c200a4f434150582061696d7320746f2070726f76696465206120726f6275737420736f6c7574696f6e20666f7220646563656e7472616c697a65642066696e616e63652028446546692920706c6174666f726d732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreifveofqq6563lhcffeetbbrioe37yzcicohplbvygxbkjcpb2wada.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OROSACAPITAL>(&mut v2, 10000000000000000, @0x1bc583a5a4b5a9ebecf86c8402696d829e722d15e8c91d4fd2bf5a5c3dae2a1a, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OROSACAPITAL>>(v2, @0x1bc583a5a4b5a9ebecf86c8402696d829e722d15e8c91d4fd2bf5a5c3dae2a1a);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OROSACAPITAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

