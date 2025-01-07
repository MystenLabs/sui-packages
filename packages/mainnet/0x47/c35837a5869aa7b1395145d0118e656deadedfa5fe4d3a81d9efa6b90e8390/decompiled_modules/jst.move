module 0x47c35837a5869aa7b1395145d0118e656deadedfa5fe4d3a81d9efa6b90e8390::jst {
    struct JST has drop {
        dummy_field: bool,
    }

    fun init(arg0: JST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JST>(arg0, 9, b"JST", b"js", b"this token make on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2e2476b-ac5a-4cb1-a045-46e7cb49d0a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JST>>(v1);
    }

    // decompiled from Move bytecode v6
}

