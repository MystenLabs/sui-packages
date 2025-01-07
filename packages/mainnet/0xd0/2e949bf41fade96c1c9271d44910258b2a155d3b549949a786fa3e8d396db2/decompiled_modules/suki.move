module 0xd02e949bf41fade96c1c9271d44910258b2a155d3b549949a786fa3e8d396db2::suki {
    struct SUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKI>(arg0, 6, b"SUKI", b"Suki Sui Dolphin", x"53756b692c20746865206f6e6520616e64206f6e6c7920646f6c7068696e20726561647920746f2072756c65207468652073656173206f6e20535549210a4e6f206f6e652063616e20636f6d7065746520776974682075730a7765206172652053756b692c20616e642077652061726520746865206b696e6773206f6620746865206f6365616e2120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suki_c7b94140fb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

