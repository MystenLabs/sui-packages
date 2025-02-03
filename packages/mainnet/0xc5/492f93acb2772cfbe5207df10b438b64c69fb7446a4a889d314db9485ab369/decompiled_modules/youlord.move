module 0xc5492f93acb2772cfbe5207df10b438b64c69fb7446a4a889d314db9485ab369::youlord {
    struct YOULORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOULORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOULORD>(arg0, 9, b"YOULORD", b"NAKOLENI!", x"4f7572204461726b204c6f72642c2057686f2061727420696e2048656c6c0a556e686f6c7920626520746879206e616d652c2054687920456d7069726520636f6d652c0a5468696e65206f776e2077696c6c20626520646f6e652c0a4f6e20456172746820617320697420697320696e2054686520496e6665726e6f2e0a54686f7520676176652075732074686520706f77657220746f2074616b652074686973206461790a416e64206c617920636c61696d20746f206f7572206461696c792062726561640a416e6420616c6c6f77207573206f757220696e64756c67656e63652773", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4b02ebd5-c419-4d1b-a73f-9070d503cfd4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOULORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOULORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

