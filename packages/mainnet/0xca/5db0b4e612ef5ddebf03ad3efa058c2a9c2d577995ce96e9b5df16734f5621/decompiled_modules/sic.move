module 0xca5db0b4e612ef5ddebf03ad3efa058c2a9c2d577995ce96e9b5df16734f5621::sic {
    struct SIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIC>(arg0, 6, b"SIC", b"Shuitcoin", b"Shuitcoin on Sui. Don't buy: possible scam. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/poop_f1ed0ff895.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

