module 0x1d4bb77a723ba2cf23bb29a421e87771d6b65a9766402ebca6c2547de7d677d9::des {
    struct DES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DES>(arg0, 9, b"DES", b"Desteany", b"LFF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af46005a-5749-43e7-9e7a-d39589d189df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DES>>(v1);
    }

    // decompiled from Move bytecode v6
}

