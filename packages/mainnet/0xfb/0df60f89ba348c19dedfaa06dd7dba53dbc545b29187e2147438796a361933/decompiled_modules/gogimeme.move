module 0xfb0df60f89ba348c19dedfaa06dd7dba53dbc545b29187e2147438796a361933::gogimeme {
    struct GOGIMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGIMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGIMEME>(arg0, 9, b"GOGIMEME", b"Gogimeme ", b"Gogimeme is Meme Coin It's For Fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/531aabab-d835-45ec-93ae-d78963351517-Screenshot_20240928-123641_1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGIMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOGIMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

