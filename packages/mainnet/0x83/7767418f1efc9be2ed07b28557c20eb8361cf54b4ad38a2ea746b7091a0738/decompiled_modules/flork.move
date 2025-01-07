module 0x837767418f1efc9be2ed07b28557c20eb8361cf54b4ad38a2ea746b7091a0738::flork {
    struct FLORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLORK>(arg0, 6, b"Flork", b"Flork On Sui", b"The universe is vast, and I'm just a slightly confused oval.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cropped_icon_5648ad8b6d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

