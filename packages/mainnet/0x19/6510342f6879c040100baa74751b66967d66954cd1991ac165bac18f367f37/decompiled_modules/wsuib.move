module 0x196510342f6879c040100baa74751b66967d66954cd1991ac165bac18f367f37::wsuib {
    struct WSUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSUIB>(arg0, 6, b"WSUIB", b"Wall Sui Boys", b"The wolves of the sui network are coming ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026505_a51c216fd6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSUIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSUIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

