module 0x9eaeeaf046c27ac26468cdc68c0c3d41bf58b346170a25acac0836d525860b04::ttcoin {
    struct TTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTCOIN>(arg0, 9, b"TTCOIN", b"tatalCoin", b"tatal bet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d2f23a37-4532-45c7-b47c-c1473b520db4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

