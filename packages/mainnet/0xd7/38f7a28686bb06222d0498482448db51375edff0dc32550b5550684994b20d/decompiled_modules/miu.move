module 0xd738f7a28686bb06222d0498482448db51375edff0dc32550b5550684994b20d::miu {
    struct MIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIU>(arg0, 6, b"MIU", b"Miu", b"MIU: The ultimate cat meme token on the Sui Network! Fun, staking, and powerful tools combined with endless purrfection. Join us and leave your paw print on the blockchain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_d2032da1d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIU>>(v1);
    }

    // decompiled from Move bytecode v6
}

