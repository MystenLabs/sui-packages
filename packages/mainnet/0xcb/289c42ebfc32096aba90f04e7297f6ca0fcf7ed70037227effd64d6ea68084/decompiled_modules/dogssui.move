module 0xcb289c42ebfc32096aba90f04e7297f6ca0fcf7ed70037227effd64d6ea68084::dogssui {
    struct DOGSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSSUI>(arg0, 6, b"DogsSui", b"Sui Dogs", x"222057686f6576657220736169642074686174206469616d6f6e647320776572652061206769726c2773206265737420667269656e642e2e2e204e65766572206f776e6564206120646f6720220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Dogs_88f52d48d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

