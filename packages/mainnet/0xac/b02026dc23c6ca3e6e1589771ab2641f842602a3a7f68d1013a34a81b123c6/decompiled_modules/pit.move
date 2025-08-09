module 0xacb02026dc23c6ca3e6e1589771ab2641f842602a3a7f68d1013a34a81b123c6::pit {
    struct PIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIT>(arg0, 6, b"PIT", b"Pitbull", b"Pitbull Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1754774377020.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

