module 0x31f99f8104a5ccbb52318e74d3537b4a91fc1d25583524d00183d846a3c6b95e::donkey {
    struct DONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONKEY>(arg0, 9, b"DONKEY", b"Donkey ", x"4120646f6e6b6579206973206c696b65206120686f727365207468617420746f6f6b20612067617020796561722c206465636964656420746f206368696c6c2c20616e64206d617374657265642074686520617274206f662073747562626f726e6e6573732e204b6e6f776e20666f722074686569722062696720656172732c206c6f75642062726179732c20616e6420e2809c49e280996c6c20646f206974207768656e2049206665656c206c696b65206974e2809d2061747469747564652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/603a7a05-676f-4997-9041-ad0e42b72c24.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

