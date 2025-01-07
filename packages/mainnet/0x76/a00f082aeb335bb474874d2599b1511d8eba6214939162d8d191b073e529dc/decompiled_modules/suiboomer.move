module 0x76a00f082aeb335bb474874d2599b1511d8eba6214939162d8d191b073e529dc::suiboomer {
    struct SUIBOOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOOMER>(arg0, 6, b"SuiBoomer", b"Sui Boomer", b"Its boom on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bg_f8f8f8_flat_750x_075_f_pad_750x1000_f8f8f8_9e30d2e002.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOOMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

