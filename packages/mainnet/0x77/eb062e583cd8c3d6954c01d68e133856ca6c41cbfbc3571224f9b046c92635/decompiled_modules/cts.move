module 0x77eb062e583cd8c3d6954c01d68e133856ca6c41cbfbc3571224f9b046c92635::cts {
    struct CTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTS>(arg0, 9, b"CTS", b"CCATS", b"My dear I'm a CCATS everything I see is mine community first let ride", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2f9afdc9-b191-4e8d-bbe1-8c30638e9570.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

