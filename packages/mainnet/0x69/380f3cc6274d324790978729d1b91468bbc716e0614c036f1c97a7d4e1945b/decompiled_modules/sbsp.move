module 0x69380f3cc6274d324790978729d1b91468bbc716e0614c036f1c97a7d4e1945b::sbsp {
    struct SBSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBSP>(arg0, 6, b"SBSP", b"Sponge Bob Suipants", b"Join us on our journey to be the king of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5454_012a737dba.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBSP>>(v1);
    }

    // decompiled from Move bytecode v6
}

