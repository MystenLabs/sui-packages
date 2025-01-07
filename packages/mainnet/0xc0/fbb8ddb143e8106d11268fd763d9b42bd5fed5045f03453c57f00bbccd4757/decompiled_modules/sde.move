module 0xc0fbb8ddb143e8106d11268fd763d9b42bd5fed5045f03453c57f00bbccd4757::sde {
    struct SDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDE>(arg0, 9, b"SDE", b"SKY", b"THE SKY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29b66e8b-0121-40c6-93bb-dbf026123d07.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

