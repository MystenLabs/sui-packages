module 0xeab58b714b1bb60eb4915af5b8d3ba2ba2a1b97f1094c8c51aabbd28fd75934b::ltcb {
    struct LTCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LTCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LTCB>(arg0, 9, b"LTCB", b"LathosClub", x"4c6174686f7320436c756220284c54434229206e6f20657320736f6c6f20756e612063726970746f6d6f6e6564613b206573206c6120707565727461206120756e2065636f73697374656d61206578636c757369766f20646520696e6e6f76616369c3b36e2079206f706f7274756e6964616465732e2041756e717565206e61636520636f6d6f206d6f6e656461206d656d652c206573207475207072696d6572207061736f207061726120666f726d61722070617274652064656c20636c756220646f6e646520746f646f20657320706f7369626c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9aaab2ca-26fb-4945-8581-7bfcf628ecd2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LTCB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LTCB>>(v1);
    }

    // decompiled from Move bytecode v6
}

