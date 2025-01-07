module 0x29f883c14aa255c509f348a983dca4899881b74ee46c3fef92d93ded40326c2b::tbtc {
    struct TBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBTC>(arg0, 9, b"TBTC", b"TBTC LABS", b"We are all going to have fun with this guys, come on!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8ded8e7e-b278-404e-8291-8f7c7fd8635d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

