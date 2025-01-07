module 0x876624a914be41e2e6be86d605f9d320d40b39f3e271c253723c779e31b4e293::pj {
    struct PJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PJ>(arg0, 9, b"PJ", b"Pojjon", b"A testing token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c96b3f9f-58e1-4641-8275-02bdc3b1de64.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

