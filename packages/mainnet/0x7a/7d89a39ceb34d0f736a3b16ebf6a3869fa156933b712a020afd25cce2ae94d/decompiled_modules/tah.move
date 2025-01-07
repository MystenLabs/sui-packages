module 0x7a7d89a39ceb34d0f736a3b16ebf6a3869fa156933b712a020afd25cce2ae94d::tah {
    struct TAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAH>(arg0, 6, b"Tah", b"Tahrem", b"First indecisive token.. We run or we don't ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730963176583.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

