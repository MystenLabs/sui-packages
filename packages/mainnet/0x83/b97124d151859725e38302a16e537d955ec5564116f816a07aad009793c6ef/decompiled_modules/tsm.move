module 0x83b97124d151859725e38302a16e537d955ec5564116f816a07aad009793c6ef::tsm {
    struct TSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSM>(arg0, 9, b"TSM", b"Tasnm", b"Good luck for the web3 token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/48f0abc8-bc87-4a56-9a08-f784d11af913.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

