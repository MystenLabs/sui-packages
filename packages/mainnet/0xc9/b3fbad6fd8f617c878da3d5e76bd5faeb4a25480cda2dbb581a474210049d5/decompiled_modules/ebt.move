module 0xc9b3fbad6fd8f617c878da3d5e76bd5faeb4a25480cda2dbb581a474210049d5::ebt {
    struct EBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBT>(arg0, 8, b"EBT", b"Everybody Broke Today", b"food stamp coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arivmarketplace.sirv.com/Restaurant%20Images/ebt250.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EBT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

