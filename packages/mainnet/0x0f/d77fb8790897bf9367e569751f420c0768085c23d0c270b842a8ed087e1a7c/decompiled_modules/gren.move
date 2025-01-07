module 0xfd77fb8790897bf9367e569751f420c0768085c23d0c270b842a8ed087e1a7c::gren {
    struct GREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREN>(arg0, 6, b"Gren", b"Gren REX", b"Something big and gren coming  exclusively", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dino_eef0d51b38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

