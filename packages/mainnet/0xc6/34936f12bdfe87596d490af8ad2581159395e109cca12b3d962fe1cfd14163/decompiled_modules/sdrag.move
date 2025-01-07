module 0xc634936f12bdfe87596d490af8ad2581159395e109cca12b3d962fe1cfd14163::sdrag {
    struct SDRAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDRAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDRAG>(arg0, 6, b"SDRAG", b"Sui Dragon Coin", x"537569447261676f6e206973206120636f6d6d756e6974792d64726976656e20646563656e7472616c697a6564206d656d6520746f6b656e2077697468206120646564696361746564207465616d2c2070757368696e6720616e6420646576656c6f70696e6720626568696e6420746865207363656e657320746f206d616b6520746869732074686520626967676573742047726f7720636f696e206f662032303234210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Dragon_Coin_b594d6453e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDRAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDRAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

