module 0x437506416d6d10ec8ab296a1d7112b48427a231cbb121bf4fd65b3c9eb09d36::llp {
    struct LLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLP>(arg0, 9, b"LLP", b"lamp", b"like the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8306455-95fc-49ff-9c01-c75757e87a69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLP>>(v1);
    }

    // decompiled from Move bytecode v6
}

