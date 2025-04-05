module 0xbfe2986d2fb2937a732e46abaeb2a24664edd9b8712076c6d86aca0c99eb15f5::catsui {
    struct CATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSUI>(arg0, 9, b"CATSUI", b"Cateryum", b"Cat of Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c256d69866f28ebb2b5be0528826d5beblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

