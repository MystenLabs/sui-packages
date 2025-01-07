module 0xf1d98d81512db2f65be5a584587073b51ea216ed6705f0b0bfe6ae13ff820805::suido {
    struct SUIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDO>(arg0, 6, b"SUIDO", b"Sui Doodles", x"546865206669727374204e46542b204d656d657320696e205375692e0a57652077696c6c2061697264726f7020746f206f75722066697273742031303020627579657273206166746572206c697374696e6720696e204445582e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000087184_8f526b86ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

