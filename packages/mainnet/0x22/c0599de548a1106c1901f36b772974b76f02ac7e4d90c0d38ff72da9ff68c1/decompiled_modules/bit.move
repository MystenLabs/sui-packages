module 0x22c0599de548a1106c1901f36b772974b76f02ac7e4d90c0d38ff72da9ff68c1::bit {
    struct BIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIT>(arg0, 6, b"BIT", b"BIT COIN", b"Bitten Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bit_coin_ca02571a1d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

