module 0xd12de37beb9910caf7908afae41785bac635bc9aeed2ecacfcd2e501883ccffe::revenge {
    struct REVENGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: REVENGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REVENGE>(arg0, 6, b"REVENGE", b"Dog Revenge", b"Whatever Your Pain, Call The Dogs. It's Time For Revenge!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731607960089.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REVENGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REVENGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

