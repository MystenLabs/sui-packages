module 0x294f66ad5db318759cb927f50b53dd6147a1ee8350ae808abd178a0c90ab4218::cfuocat_8b9847b447d491cc {
    struct CFUOCAT_8B9847B447D491CC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFUOCAT_8B9847B447D491CC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CFUOCAT_8B9847B447D491CC>(arg0, 0, b"CFUOCAT", b"CFUOCAT", b"Pump-style launch token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suigift.fun/api/uploads/token-icons/1788191459681-3ad204cf-2e27-4b68-8cda-7bc8490237ea.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CFUOCAT_8B9847B447D491CC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CFUOCAT_8B9847B447D491CC>>(0x2::coin::mint<CFUOCAT_8B9847B447D491CC>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFUOCAT_8B9847B447D491CC>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

