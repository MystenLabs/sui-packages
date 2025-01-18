module 0x8f763a823985995f53a4e89151a9aa05bf432d45aad0931cf1460f58a8bc89bc::OXI {
    struct OXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OXI>(arg0, 9, b"OXI", b"OXI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OXI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OXI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<OXI>>(0x2::coin::mint<OXI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

