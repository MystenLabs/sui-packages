module 0xa5e4380991f80803ae3e3cdfa6b3f005a960657fa908417d722fd74cb842a6c6::suivear {
    struct SUIVEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVEAR>(arg0, 9, b"SUIVEAR", b"Suivear", x"69736e2774206a757374206120746f6b656e3b206974277320612074657374616d656e7420746f20656e647572616e63652c20612063616c6c20746f2072616c6c792061726f756e64207468652076697274756573206f662070657273697374656e636520616e64207265736f6c7665207468617420646566696e652074727565206c6561646572736869702e20497427732074696d6520746f207472756c79206c697374656ee280946e6f74206a75737420746f20746865206c6f756420616e6420696d6d6564696174652c2062757420746f2074686520736f667420616e64207369676e69666963616e742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://prsvear.us/images/trump.svg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIVEAR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVEAR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

