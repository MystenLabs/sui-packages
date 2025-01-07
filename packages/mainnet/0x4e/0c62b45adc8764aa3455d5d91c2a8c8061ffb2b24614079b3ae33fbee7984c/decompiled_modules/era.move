module 0x4e0c62b45adc8764aa3455d5d91c2a8c8061ffb2b24614079b3ae33fbee7984c::era {
    struct ERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERA>(arg0, 2, b"Era", b"Eralysis", b"Eralysis is a analysis platform for traders for anlyse their next investment and traders can also create NFT's of his investment strateegy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ERA>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ERA>>(v1);
    }

    // decompiled from Move bytecode v6
}

