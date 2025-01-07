module 0x3f7037535d56ca0594ae887b1ae610ff6190257c578a10fcfaf2a7b63053caf3::suinic {
    struct SUINIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIC>(arg0, 6, b"SUINIC", b"SUINIC INU", b"Meet SuinicInu, the speedy sensation inspired by the iconic cartoon character, Sonic the Hedgehog! As the fastest runner on the Sui network, SuinicInu is not just a meme; it's a community-driven project dedicated to providing a safe and enjoyable experience for everyone. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_09_32_03_9231babcff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

