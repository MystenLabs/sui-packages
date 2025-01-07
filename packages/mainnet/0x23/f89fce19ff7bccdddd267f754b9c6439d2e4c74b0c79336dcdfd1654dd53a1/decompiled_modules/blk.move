module 0x23f89fce19ff7bccdddd267f754b9c6439d2e4c74b0c79336dcdfd1654dd53a1::blk {
    struct BLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLK>(arg0, 6, b"BLK", b"Blackcoin", b"Home of $BLK on SUI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BCOIN_acbbc8440b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

