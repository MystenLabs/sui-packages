module 0x15cea322e5b5a701d4333451db46ef857adb6af9efec9371569fe8def84d22c5::gary {
    struct GARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARY>(arg0, 6, b"GARY", b"GARY THE SUISNAIL", b"Come Home, Gary!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifx6ur4egxpopkldk4orppxtolxv7rra252nbdny6iry432uiwfp4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GARY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

