module 0xaa050161308299e05e19daaf2cd46a8366a2c9e3f578dc29e9df1b469afd721d::delayfun {
    struct DELAYFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELAYFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELAYFUN>(arg0, 6, b"Delayfun", b"Delay.fun", b"Fucking hop better Turbo ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959651292.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DELAYFUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELAYFUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

