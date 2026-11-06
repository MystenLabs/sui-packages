module 0x49edb359b032781a63289c126a61c0e18ded14afc158d7f04428203a34fd876d::o494 {
    struct O494 has drop {
        dummy_field: bool,
    }

    fun init(arg0: O494, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<O494>(arg0, 6, b"O494", b"O494", b"O494 LP coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<O494>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<O494>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

