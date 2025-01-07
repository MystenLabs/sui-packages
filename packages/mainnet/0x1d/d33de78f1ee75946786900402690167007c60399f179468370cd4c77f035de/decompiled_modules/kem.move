module 0x1dd33de78f1ee75946786900402690167007c60399f179468370cd4c77f035de::kem {
    struct KEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEM>(arg0, 9, b"KEM", b"Poodle Dog", b"My lovely poodle dog name is Kem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0d2f02d3-d5f7-4e10-b5dc-1a040e39d9a9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

