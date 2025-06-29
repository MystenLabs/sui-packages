module 0x684e7f0aeb447e137bc7205acd39f735cc0f168f376f9f12070c280bceccb9bb::psi {
    struct PSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSI>(arg0, 9, b"PSi", b"$PSi", b"$PSi Finance started !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/de45895e5d8f709c70130cc01ca5c719blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

