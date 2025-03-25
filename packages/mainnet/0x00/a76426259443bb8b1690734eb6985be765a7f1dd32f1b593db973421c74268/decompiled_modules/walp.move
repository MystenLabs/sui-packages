module 0xa76426259443bb8b1690734eb6985be765a7f1dd32f1b593db973421c74268::walp {
    struct WALP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALP>(arg0, 9, b"Walp", b"walpaws", b"just walrus", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0bed74a6515957071016bfab1af7df22blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

