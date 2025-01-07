module 0x581199f27e107a210f4c796ba8c1ae42e0d419c574812e531be083c94d1ef6c7::ex {
    struct EX has drop {
        dummy_field: bool,
    }

    fun init(arg0: EX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EX>(arg0, 6, b"EX", b"Expatryk", b"Extreme rewards in the futures ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730757788236.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

