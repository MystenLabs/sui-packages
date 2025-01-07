module 0x30cf0eaf0e5abfbf8ee0d5f63e59817d2a08d65dbe6677b0474169e016c67c28::wwp {
    struct WWP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWP>(arg0, 9, b"WWP", b"WEWEPUMPP", b"WEWEPUMP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b583624-f7b2-4427-bcf4-1fd8a16753e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WWP>>(v1);
    }

    // decompiled from Move bytecode v6
}

