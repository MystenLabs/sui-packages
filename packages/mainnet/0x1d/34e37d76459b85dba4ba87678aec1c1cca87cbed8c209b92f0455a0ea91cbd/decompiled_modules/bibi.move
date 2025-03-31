module 0x1d34e37d76459b85dba4ba87678aec1c1cca87cbed8c209b92f0455a0ea91cbd::bibi {
    struct BIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBI>(arg0, 6, b"BIBI", b"Bibi", x"244249424920746865204261672042756c6c79200a0a204b494e47206f66207468652043727970746f7665727365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052771_6fa716ab72.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

