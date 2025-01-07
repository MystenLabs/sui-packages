module 0x7e23ca1c15a7b47c21d57cb84ca023b53875d74dd55a4b6dbe039f852697adb0::clob {
    struct CLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOB>(arg0, 9, b"CLOB", b"CLOB onSUI", b"Central Liquidity Ordered Book, exclusive on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5e09a012-01ec-4dbd-875a-1de94b989f6a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

