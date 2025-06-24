module 0x8d51787d0560496239accf906d6084f239c4d708d29e940af8053942e8544e00::unreg {
    struct UNREG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNREG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNREG>(arg0, 6, b"UNREG", b"UNREGISTEREDSECURITY", b"Very unregistered", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750753792493.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNREG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNREG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

