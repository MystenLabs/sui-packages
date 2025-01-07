module 0x8b6ac93f60101665391439df33883ad4af28bad5051cdefd2f0c8652faeb7469::camela {
    struct CAMELA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAMELA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAMELA>(arg0, 6, b"CAMELA", b"CAMELA HARRIS", x"2043414d454c41204841525249530a5468652076657279206669727374204b616d616c6120486172726973207468656d656420746f6b656e206f6e2074686520737569206e6574776f726b2e0a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4075_26d139d6b2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAMELA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAMELA>>(v1);
    }

    // decompiled from Move bytecode v6
}

