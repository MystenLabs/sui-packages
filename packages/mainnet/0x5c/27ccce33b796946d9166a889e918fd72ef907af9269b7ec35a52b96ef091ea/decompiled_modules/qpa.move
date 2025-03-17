module 0x5c27ccce33b796946d9166a889e918fd72ef907af9269b7ec35a52b96ef091ea::qpa {
    struct QPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: QPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QPA>(arg0, 9, b"QPA", b"Quang Phap", b"Hello sir", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2d7740b8-e97e-4028-883b-fe5123721c2b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

