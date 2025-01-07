module 0x12998f6236f245802ac05e7b4c333dc2c47d4e910154e7d848f4b7ab2c6a20db::sbrat {
    struct SBRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBRAT>(arg0, 6, b"SBRAT", b"Sui Brat", b" Merges the iconic characters of Brett by Matt Furie and Bart Simpson into the world of cryptocurrency", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul65_20250103024935_154e603423.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

