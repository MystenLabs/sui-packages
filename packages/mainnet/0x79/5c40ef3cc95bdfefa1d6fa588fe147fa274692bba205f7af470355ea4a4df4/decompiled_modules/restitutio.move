module 0x795c40ef3cc95bdfefa1d6fa588fe147fa274692bba205f7af470355ea4a4df4::restitutio {
    struct RESTITUTIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RESTITUTIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RESTITUTIO>(arg0, 9, b"RESTITUTIO", b"RESTORATIO", b"Coin that will pump money into the crypto space and more utility token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9dd774d-2e21-40f3-a37f-fc3532e1a9c4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RESTITUTIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RESTITUTIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

