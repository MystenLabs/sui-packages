module 0x94b0b979b1413d356da19faeeec179b0c36f2aa71a8da14fe244df26de9eeca5::gogimeme {
    struct GOGIMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOGIMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOGIMEME>(arg0, 9, b"GOGIMEME", b"Gogimeme ", b"Gogimeme is Meme Coin It's For Fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0a90485-49c7-4ac1-8c08-2bc56b9bbe05-Screenshot_20240928-123641_1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOGIMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOGIMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

