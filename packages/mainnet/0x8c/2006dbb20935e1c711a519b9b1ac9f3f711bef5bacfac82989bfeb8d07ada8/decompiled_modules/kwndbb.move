module 0x8c2006dbb20935e1c711a519b9b1ac9f3f711bef5bacfac82989bfeb8d07ada8::kwndbb {
    struct KWNDBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWNDBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWNDBB>(arg0, 9, b"KWNDBB", b"sjjsn", b"idjsn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/36453bc9-7496-4a28-b0ae-7a2e9d61123b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWNDBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KWNDBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

