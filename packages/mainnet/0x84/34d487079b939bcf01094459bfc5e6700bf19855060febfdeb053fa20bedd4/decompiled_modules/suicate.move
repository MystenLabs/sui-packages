module 0x8434d487079b939bcf01094459bfc5e6700bf19855060febfdeb053fa20bedd4::suicate {
    struct SUICATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATE>(arg0, 6, b"SUICATE", b"Sui Cate", b"\"SUIcate - the curious guardian of the Sui network, always alert and ready to surf the blockchain waves with style and charm!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000248665_ee6d644839.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

