module 0x4b7d66ff4ccb20b0e989e1d7f73b7b7fc2903dcc26d260eeb077931804c953ed::cldogs {
    struct CLDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLDOGS>(arg0, 9, b"CLDOGS", b"CLDOG", x"5775726d70204d656d6520436f696e20736f756e6473206c696b652061206a6f6b652062757420492063616ee28099742068656c70206265696e6720696e7465726573746564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1569566-5ad8-4387-a755-85cab1adc072.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

