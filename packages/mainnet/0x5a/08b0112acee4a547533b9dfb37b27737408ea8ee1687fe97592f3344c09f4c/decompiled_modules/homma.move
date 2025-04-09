module 0x5a08b0112acee4a547533b9dfb37b27737408ea8ee1687fe97592f3344c09f4c::homma {
    struct HOMMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMMA>(arg0, 9, b"HOMMA", b"HOMMA SIMPSON", b"HOMMA ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1bd39e98780c1d9313dd263d6ebf75b2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOMMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

