module 0xf435ac81672ca7cc77fb36099dc75cc049223aa2890d672f088eba553770ec68::nell {
    struct NELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NELL>(arg0, 6, b"NELL", b"The Screw Tape", b"fuck ya mudda", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeif4p57azlg7gthutyw7uieg64ytxbe3bcaxjyxrquckks5pgmvuja")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NELL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

