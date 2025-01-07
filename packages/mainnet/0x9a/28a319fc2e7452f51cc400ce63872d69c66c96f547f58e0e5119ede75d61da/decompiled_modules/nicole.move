module 0x9a28a319fc2e7452f51cc400ce63872d69c66c96f547f58e0e5119ede75d61da::nicole {
    struct NICOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NICOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NICOLE>(arg0, 9, b"nicole", b"Nicole Aniston", b"Nicole Aniston is the original cute mascot of the Sui blockchain ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdns-images.dzcdn.net/images/cover/adb1235539fa542efcd3d1152c5789a3/0x1900-000000-80-0-0.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NICOLE>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NICOLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NICOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

