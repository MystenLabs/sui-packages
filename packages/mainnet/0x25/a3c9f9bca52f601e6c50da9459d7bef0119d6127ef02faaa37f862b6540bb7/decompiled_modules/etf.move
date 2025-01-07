module 0x25a3c9f9bca52f601e6c50da9459d7bef0119d6127ef02faaa37f862b6540bb7::etf {
    struct ETF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETF>(arg0, 9, b"ETF", b"What the Fuck", b"Provoking laughter and confusion, asking the hard questions: \"What the heck?!\" Fueling chaos since its viral birth! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/22c9c3f67e0ee4cf2176ff6d66539576blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

