module 0xd05735a010f6bf3584d299664bc801ee48016a11ba3b384191539b80e133d188::mft {
    struct MFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MFT>(arg0, 6, b"MFT", b"MisfitCoin ", b"To ensure MisfitCoin thrives, the key is community-first growth paired with real-world utility and a mission that goes beyond just financial gain. By fostering a space where people can express their individuality freely, MisfitCoin can stand out ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736220540707.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MFT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

