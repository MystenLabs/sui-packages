module 0xcdd9aab2a79327118028c7b00bd1e4fa892d43484d1488a1423d0d2eae570f9::wartocen {
    struct WARTOCEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARTOCEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARTOCEN>(arg0, 9, b"WARTOCEN", b"WAR", b"Token of WAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2b91184-4863-42ba-b6da-852fe4e3c0de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARTOCEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WARTOCEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

