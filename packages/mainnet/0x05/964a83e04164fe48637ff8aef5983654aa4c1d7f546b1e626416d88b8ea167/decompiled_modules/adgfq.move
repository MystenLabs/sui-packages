module 0x5964a83e04164fe48637ff8aef5983654aa4c1d7f546b1e626416d88b8ea167::adgfq {
    struct ADGFQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADGFQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADGFQ>(arg0, 9, b"ADGFQ", b"ASDFQA", b"ASFASF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/495ad812-21f2-48b3-9844-407f059b9446.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADGFQ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADGFQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

