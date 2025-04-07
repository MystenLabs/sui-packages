module 0xee97d9035ad81b6076742505840e8e76042463b180b9ec7dfb4f3b8d1cf84043::cunt {
    struct CUNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUNT>(arg0, 9, b"CUNT", b"Hellcat", b"You know the ones", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f5823e70fc908d9d463d8f1f94557fc2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUNT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUNT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

