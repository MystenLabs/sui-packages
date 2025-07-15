module 0x331ea4e55b360073d16ca0b29876bc8124b8003021a7ca68d350e743fd844803::bit {
    struct BIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIT>(arg0, 6, b"BIT", b"AMERICAN BITCOIN", b"AMERICAN BITCOIN US", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752585847636.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

