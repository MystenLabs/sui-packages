module 0xa09966e569709f0c8409b7cdeceb789b7d6705bc0eeaf939c975e6d9ed431162::smfcoin {
    struct SMFCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMFCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMFCOIN>(arg0, 9, b"SMFCOIN", b"SMF", b"SMF COIN IS A COMMUNITY TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1492ffc6-f0a2-4473-934f-86818a9bd1e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMFCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMFCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

