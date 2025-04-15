module 0x37404afe0a3f08375959874def1945dbebf029de34fef25ee55c04e151074e0::mbg {
    struct MBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBG>(arg0, 6, b"MBG", b"Moonbags Official", b"Official Coin of Moonbags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreib6pcmduiuug6yipr4ljooa3rebmprbvxgj3f6t3vyp3sx7cau25a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MBG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

