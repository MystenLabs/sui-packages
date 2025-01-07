module 0x6bab8ae32adfed8e3c9abf9a719c0984edc392df3a5b783b233352dc66bdeb00::mangpor {
    struct MANGPOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANGPOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANGPOR>(arg0, 6, b"MANGPOR", b"NONG MANGPOR", x"4d656574204e6f6e67204d616e67706f722028e0b899e0b989e0b8ade0b887e0b981e0b8a1e0b887e0b89be0b8ad292c20616e2061646f7261626c6520796f756e672074696765722066726f6d20436869616e67204d6169204e696768742053616661726920696e20546861696c616e6421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732235858471.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANGPOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANGPOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

