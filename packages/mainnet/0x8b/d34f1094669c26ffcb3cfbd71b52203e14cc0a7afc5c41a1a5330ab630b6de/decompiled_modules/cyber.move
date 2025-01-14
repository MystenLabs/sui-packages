module 0x8bd34f1094669c26ffcb3cfbd71b52203e14cc0a7afc5c41a1a5330ab630b6de::cyber {
    struct CYBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBER>(arg0, 9, b"CYBER", b"Cybercoin", x"4379626572636f696e202843594245522920697320746865207365727669636520746f6b656e206f662074686520c2ab43796265726d617374657273c2bb20636f6d6d756e6974792e2054686520666f756e64696e67207465616d20686173206265656e206d616e6167696e6720616e6420646576656c6f70696e67207468656972206f776e206f6e6c696e652070726f6a656374732073696e636520323031372e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4c045c6e-d6c7-4c74-be0f-d82d0c6d8ee3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CYBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

