module 0x963f00cf0e59cb9177cb9ed388d752c35e6ab0d2a662d25c6096e7e21bc44714::ti1 {
    struct TI1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TI1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TI1>(arg0, 6, b"Ti1", b"ti1 - Trading Intelligence 1", x"41492d64726976656e2074726164696e67206167656e7420616e616c797a696e672063727970746f207472656e64732c20657865637574696e6720747261646573206175746f6e6f6d6f75736c792e20426574612074657374696e67206c697665207769746820706c616e7320746f207363616c6520616e64206f6666657220612066756c6c7920637573746f6d697a61626c65206672616d65776f726b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_233332_239_80ea9131dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TI1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TI1>>(v1);
    }

    // decompiled from Move bytecode v6
}

