module 0x61f664ecbe38e4f693d99753608ac77138224a98caaf04ef5fb580f682e134::sray {
    struct SRAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRAY>(arg0, 6, b"SRAY", b"Silly Ray", b"$SRAY a stingray looking for friendship", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib7vbiflevqsejcotdyz5rcz7daf5ew332djjoqqdwwsykn3e4yle")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SRAY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

