module 0x143282c8e32b8a496b7cabce889ffbfee7d56192916cf7bc894ee09d8a993433::pgs {
    struct PGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGS>(arg0, 9, b"PGS", b"PEGASUS", b"MEME FOR FUN ;)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4143772d-f47a-47c8-bfcc-02b89a5061f1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

