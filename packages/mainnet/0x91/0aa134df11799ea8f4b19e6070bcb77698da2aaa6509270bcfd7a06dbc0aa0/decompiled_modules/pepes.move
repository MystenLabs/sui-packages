module 0x910aa134df11799ea8f4b19e6070bcb77698da2aaa6509270bcfd7a06dbc0aa0::pepes {
    struct PEPES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPES>(arg0, 9, b"PEPES", b"PEPE o SUI", x"496e74726f647563696e67205065706573206f6e2053756920e28093206120756e6971756520746f6b656e206c61756e63682063656c6562726174696e6720506570652c206e6f77206f6e207468652053756920626c6f636b636861696e212047657420796f7572205065706573206f6e2053756920616e64206a6f696e207468652066756e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e50b67aa-fd2f-416e-bcfe-400e0ef064b2-IMG_20241004_131227_986.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPES>>(v1);
    }

    // decompiled from Move bytecode v6
}

