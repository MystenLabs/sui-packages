module 0x264ecb29ae4313f7409fa14ee410f111c92e08877ebf4b2f75cae782b69a6015::wis {
    struct WIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIS>(arg0, 9, b"WIS", b"Wis Wis", b"2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98d3ea3d-02f1-49a2-a6be-badf1384ca49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

