module 0x7a935c31a5a1f6e4637139bfa499151f1595f5704a31af9ce0a6716642ea8017::crypto {
    struct CRYPTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRYPTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRYPTO>(arg0, 9, b"CRYPTO", b"Crptshrd", x"48696768207363616c6162696c6974793a20486f772043727970746f7368617264732063616e2068616e646c652061206d617373697665206e756d626572206f66207472616e73616374696f6e732e0a202a20456e68616e6365642073656375726974793a204578706c61696e20746865207365637572697479206665617475726573206f66207468652043727970746f736861726473206e6574776f726b2e0a202a20496e7465726f7065726162696c6974793a204469736375737320686f772043727970746f7368617264732063616e20696e746567726174652077697468206f7468657220626c6f636b636861696e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1e4bccb-d6a1-40a9-adb5-3df8961f8589.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRYPTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRYPTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

