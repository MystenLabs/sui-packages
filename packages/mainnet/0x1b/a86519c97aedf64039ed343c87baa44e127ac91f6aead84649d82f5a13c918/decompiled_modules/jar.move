module 0x1ba86519c97aedf64039ed343c87baa44e127ac91f6aead84649d82f5a13c918::jar {
    struct JAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAR>(arg0, 9, b"JAR", b"jarjar", b"The secure cryptocurrency that's preserving your investments, sealing in gains and keeping your portfolio fresh and thriving..... jarjar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1ccbaa5-0cf1-4ed2-9677-6f6a748e1971.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

