module 0x850c0e19464d6ea47823588fce9f24609a8f06d7553dd2680f63e2e5ae2b4b30::barron {
    struct BARRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRON>(arg0, 9, b"BARRON", b"OFFICIAL BARRON", b"Join the Barron Community. This is History in the Making!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVzntG3HeEtfC1sE7ed8cG16VCUn6E7FkXbs3Bk3vKkxJ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BARRON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARRON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRON>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

